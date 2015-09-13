#!/bin/bash

cat << EOF > /etc/onetime/config
:site:
  :host: ${ONETIME_DOMAIN:=localhost:7143}
  :domain: ${ONETIME_DOMAIN:=localhost}
  :ssl: ${SSL_ENABLED:=false}
  # NOTE Once the secret is set, do not change it (keep a backup offsite)
  :secret: CHANGEME
:redis:
  :uri: 'redis://${REDIS_HOST:=redis}:${REDIS_PORT:=6379}/0?timeout=10&thread_safe=false&logging=false'
  :config:
:colonels:
  - ${ONETIME_EMAIL_ADDRESS:=email@example.com}
:emailer:
  :mode: :${ONETIME_EMAIL_MODE:=smtp}
  :from: ${ONETIME_EMAIL_ADDRESS:=email@example.com}
  :host: localhost
  :port: 587
  :fromname: ONETIMESECRET
  :tls: false
  :user:
  :pass:
  :auth:
  :bcc:
  :aws_access_key: ${AWS_ACCESS_KEY}
  :aws_access_secret: ${AWS_ACCESS_SECRET}
  :region: ${REGION:=us-east-1}
:incoming:
  :enabled: true
  :email: example@onetimesecret.com
  :passphrase: CHANGEME
  :regex: \A[a-zA-Z0-9]{6}\z
:locales:
  - en
  - es
:unsupported_locales:
  - de
  - ru
  - fr
  - nl
  - pt
:stathat:
  :enabled: false
  :apikey: CHANGEME
  :default_chart: CHANGEME
:text:
  :nonpaid_recipient_text: 'You need to create an account!'
  :paid_recipient_text: 'Send the secret link via email'
:limits:
  :create_secret: 100
  :create_account: 3
  :update_account: 5
  :email_recipient: 10
  :send_feedback: 3
  :authenticate_session: 5
  :homepage: 100
  :dashboard: 100
  :failed_passphrase: 5
  :show_metadata: 200
  :show_secret: 100
  :burn_secret: 100
EOF

exec $(bundle exec thin -e ${RACK_ENV} -R config.ru -p 8080 start)
