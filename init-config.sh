for f in /source/config/* /source/secret/*; do
  if [ "$(basename "$f")" != "__authenticated_emails" ]; then
    v=$(cat "$f")
    # simple escape if needed
    case $v in
      "true");; "false");; "["*);; "\""*);;
      *) v="\"$v\"";;
    esac
    echo "$(basename "$f") = $v" >> /etc/oauth2-proxy/oauth2-proxy.cfg
  else
    # NOTE hack-ish way to support inline authenticated email list in config
    cat "$f" > /etc/oauth2-proxy/authenticated-emails.txt
    echo 'authenticated_emails_file = "/etc/oauth2-proxy/authenticated-emails.txt"' >> /etc/oauth2-proxy/oauth2-proxy.cfg
  fi
done

# TODO debug
cat /etc/oauth2-proxy/*
