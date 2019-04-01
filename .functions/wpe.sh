wpe() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - WPE Users") wpe-$1
  opoff
}
