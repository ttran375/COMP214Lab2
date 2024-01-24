sudo apt-get update
sudo apt-get install -y libaio1 wget unzip
wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip
wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-sqlplus-linux.x64-21.1.0.0.0.zip
unzip instantclient-basiclite-linux.x64-21.1.0.0.0.zip -d /opt/oracle
unzip instantclient-sqlplus-linux.x64-21.1.0.0.0.zip -d /opt/oracle
rm instantclient-basiclite-linux.x64-21.1.0.0.0.zip
rm instantclient-sqlplus-linux.x64-21.1.0.0.0.zip
echo 'export ORACLE_HOME=/opt/oracle/instantclient_21_1' >> ~/.bashrc
echo 'export PATH=$PATH:$ORACLE_HOME' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME' >> ~/.bashrc
source ~/.bashrc
# sqlplus COMP214_W24_nic_x/password@199.212.26.208:1521/SQLD
# SQL > @script.sql
# @JLDB_Build_8.sql
# @JLDB_Build_12.sql
