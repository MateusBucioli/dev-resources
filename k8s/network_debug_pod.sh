kubectl run net-debug --rm -i -t --image=debian:stable-slim -- bash -c "apt update -y && apt install -y dnsutils curl iputils-ping traceroute telnet && bash"
