resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  # To calculate the (finger|thumb)print:
  # $ OID_URL='https://token.actions.githubusercontent.com/.well-known/openid-configuration'
  # $ HOST=$(curl $OID_URL \
  #   | jq -r '.jwks_uri | split("/")[2]')
  # $ echo | openssl s_client -servername $HOST -showcerts -connect $HOST:443 2> /dev/null \
  #   | sed -n -e '/BEGIN/h' -e '/BEGIN/,/END/H' -e '$x' -e '$p' | tail +2 \
  #   | openssl x509 -fingerprint -noout \
  #   | sed -e "s/.*=//" -e "s/://g" | tr "ABCDEF" "abcdef"
  thumbprint_list = [
    "d89e3bd43d5d909b47a18977aa9d5ce36cee184c",
    "2b18947a6a9fc7764fd8b5fb18a863b0c6dac24f", # Generated 2025-07-30
  ]
}
