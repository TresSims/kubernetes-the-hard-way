data "vault_kv_secret_v2" "laptop_ssh" {
  mount = "tres"
  name = "laptop-01.tres.sims.family/ssh-key"
}

data "vault_kv_secret_v2" "desktop_ssh" {
  mount = "tres"
  name = "desktop-01.tres.sims.family/ssh-key"
}

