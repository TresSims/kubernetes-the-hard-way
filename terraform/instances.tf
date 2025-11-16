locals {
  worker_count = 2
  ssh-keys     = <<EOF
      tsims:${data.vault_kv_secret_v2.laptop_ssh.data.public-key}
      tsims:${data.vault_kv_secret_v2.desktop_ssh.data.public-key}
  EOF
}

resource "google_service_account" "sa-kube-cp-01" {
  account_id = "sa-kube-cp-01"
}

resource "google_compute_instance" "kube-cp-01" {
  name         = "kube-cp-01"
  machine_type = "c4-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }

  service_account {
    email  = google_service_account.sa-kube-cp-01.email
    scopes = ["cloud-platform"]
  }
}


resource "google_service_account" "sa-kube-node" {
  count      = local.worker_count
  account_id = "sa-kube-node-0${count.index + 1}"
}

resource "google_compute_instance" "kube-node" {
  count        = local.worker_count
  name         = "kube-node-0${count.index}"
  machine_type = "c4-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }

  service_account {
    email  = google_service_account.sa-kube-node[count.index].email
    scopes = ["cloud-platform"]
  }
}
