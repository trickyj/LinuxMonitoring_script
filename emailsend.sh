## Sending email ###
{
  cat <<EOF
From: pop.tricky@gmail.com
To: pop.tricky@gmail.com
Subject: my linux Servers State : `date "+%Y-%m-%d %H:%M"`
Content-Type: text/html

Hello,
Please find the below status of server at `date "+%Y-%m-%d %H:%M"`.

EOF

  cat /home/pagebrake/Documents/monitoring/Index.html
} | /usr/sbin/sendmail -t
