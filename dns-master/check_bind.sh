echo -e "\033[01;34m######  #     #  #####\033[0m"
echo -e "\033[01;34m#     # ##    # #     #\033[0m"
echo -e "\033[01;34m#     # # #   # #\033[0m"
echo -e "\033[01;34m#     # #  #  #  #####\033[0m"
echo -e "\033[01;34m#     # #   # #       #\033[0m"
echo -e "\033[01;34m#     # #    ## #     #\033[0m"
echo -e "\033[01;34m######  #     #  #####\033[0m"

echo -e "\033[01;34m#     #    #     #####  ####### ####### ######\033[0m"
echo -e "\033[01;34m##   ##   # #   #     #    #    #       #     #\033[0m"
echo -e "\033[01;34m# # # #  #   #  #          #    #       #     #\033[0m"
echo -e "\033[01;34m#  #  # #     #  #####     #    #####   ######\033[0m"
echo -e "\033[01;34m#     # #######       #    #    #       #   #\033[0m"
echo -e "\033[01;34m#     # #     # #     #    #    #       #    #\033[0m"
echo -e "\033[01;34m#     # #     #  #####     #    ####### #     #\033[0m"


echo -e "\n"

BIND=$(systemctl status named  2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")
MASTER=$(dig ns1.dcing.corp @192.168.0.202 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")
SLAVE1=$(dig ns2.dcing.corp @192.168.0.203 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")
SLAVE2=$(dig ns3.dcing.corp @192.168.0.204 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")
SLAVE3=$(dig ns4.dcing.corp @192.168.0.205 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")

echo "STATUS BIND: $BIND"
echo "ZONA MASTER: $(dig ns1.dcing.corp @192.168.0.202 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")"
echo "ZONA SLAVE1: $(dig ns2.dcing.corp @192.168.0.203 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")"
echo "ZONA SLAVE2: $(dig ns3.dcing.corp @192.168.0.204 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")"
echo "ZONA SLAVE3: $(dig ns4.dcing.corp @192.168.0.205 | grep -A1 "ANSWER SECTION" 2>&1 > /dev/null  && echo -e "\033[01;32mOK\033[0m" || echo -e "\033[01;31mNOK\033[0m")"
echo "CONFIG BIND: /etc/named.conf"
echo "CONFIG LOCAL: /etc/named/named.conf.local"
echo "FORWARDING ZONE: /var/named/"
echo "LOG BIND: /var/named/data"
