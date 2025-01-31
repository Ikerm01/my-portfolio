# Función para añadir una IP estática
añadir_ip_estatica() {
    echo "Añadir IP estática al servidor DHCP"
    read -p "Introduce la interfaz de red (ejemplo: eth0): " interfaz
    read -p "Introduce la IP estática (ejemplo: 192.168.1.10): " ip_estatica
    read -p "Introduce la máscara de subred (ejemplo: 255.255.255.0): " mascara
    read -p "Introduce la puerta de enlace (ejemplo: 192.168.1.1): " gateway
    
    # Se edita el archivo de configuración del servidor DHCP
    sudo bash -c "echo 'interface \"$interfaz\" {' >> /etc/dhcp/dhcpd.conf"
    sudo bash -c "echo '  static ip_address $ip_estatica/24;' >> /etc/dhcp/dhcpd.conf"
    sudo bash -c "echo '  routers $gateway;' >> /etc/dhcp/dhcpd.conf"
    sudo bash -c "echo '}' >> /etc/dhcp/dhcpd.conf"
    echo "IP estática añadida correctamente."
}

# Función para configurar el rango de direcciones IP
configurar_rango_ip() {
    echo "Configurar el rango de direcciones IP"
    read -p "Introduce el rango de IPs inicial (ejemplo: 192.168.1.100): " ip_inicio
    read -p "Introduce el rango de IPs final (ejemplo: 192.168.1.200): " ip_fin
    read -p "Introduce la máscara de subred (ejemplo: 255.255.255.0): " mascara
    
    # Se edita el archivo de configuración del servidor DHCP
    sudo bash -c "echo 'subnet 192.168.1.0 netmask $mascara {' >> /etc/dhcp/dhcpd.conf"
    sudo bash -c "echo '  range $ip_inicio $ip_fin;' >> /etc/dhcp/dhcpd.conf"
    sudo bash -c "echo '}' >> /etc/dhcp/dhcpd.conf"
    echo "Rango de IPs configurado correctamente."
}

# Función para configurar la duración de la concesión de IP
configurar_concesion_ip() {
    echo "Configurar la duración de la concesión de IP"
    read -p "Introduce la duración de la concesión (en segundos, ej: 600): " duracion
    sudo bash -c "echo 'default-lease-time $duracion;' >> /etc/dhcp/dhcpd.conf"
    sudo bash -c "echo 'max-lease-time $duracion;' >> /etc/dhcp/dhcpd.conf"
    echo "Duración de la concesión de IP configurada correctamente."
}

# Función para ver la configuración actual del servidor DHCP
ver_configuracion_dhcp() {
    echo "Configuración actual del servidor DHCP (dhcpd.conf):"
    cat /etc/dhcp/dhcpd.conf
}

# Función para reiniciar el servidor DHCP
reiniciar_dhcp() {
    echo "Reiniciando el servidor DHCP..."
    sudo systemctl restart isc-dhcp-server
    echo "Servidor DHCP reiniciado."
}

# Función para detener el servidor DHCP
detener_dhcp() {
    echo "Deteniendo el servidor DHCP..."
    sudo systemctl stop isc-dhcp-server
    echo "Servidor DHCP detenido."
}

# Función para iniciar el servidor DHCP
iniciar_dhcp() {
    echo "Iniciando el servidor DHCP..."
    sudo systemctl start isc-dhcp-server
    echo "Servidor DHCP iniciado."
}

# Función para ver el estado del servidor DHCP
ver_estado_dhcp() {
    echo "Estado del servidor DHCP:"
    sudo systemctl status isc-dhcp-server
}

# Función para ver el archivo de log del servidor DHCP
ver_log_dhcp() {
    echo "Mostrando el archivo de log del servidor DHCP:"
    sudo tail -n 50 /var/log/syslog | grep dhcpd
}
