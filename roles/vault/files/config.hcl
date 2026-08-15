ui = true

storage "file" {
  path = "/var/lib/vault/data"
}

listener "tcp" {
  address         = "127.0.0.1:8200"
  tls_cert_file   = "cert.pem"
  tls_key_file    = "key.pem"
  tls_min_version = "tls13"
}
