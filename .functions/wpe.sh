wpe-users() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - WPE Users") wpe-users
  opoff
}

wpe-dev() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - WPE Users") wpe-dev
  opoff
}

wpe-prod() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - WPE Users") wpe-prod
  opoff
}

wpe-corp() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - WPE Users") wpe-corp
  opoff
}

wpe-pur() {
  opon
  aws-vault exec -t 4h --assume-role-ttl=1h -m $(getmfa "AWS - WPE Users") wpe-pur
  opoff
}
