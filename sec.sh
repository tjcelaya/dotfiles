function new_self_signed_cert() {
  local FILENAME=$(cat /dev/urandom | base64 | head -c 20)
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$FILENAME.key" -out "$FILENAME.crt"
}
