# Secure Linux Data Platform Lab

**Collaborators**:  
- Linux Systems Administrator (Jacob Cross)  
- Data Governance Engineer (Dez Smith)

**Objective**:  
Simulate a secure, auditable Linux-based data platform combining system administration and data governance best practices. Built using WSL (Ubuntu).

---

## Lab Structure

- **Day 1**: Base System Setup  
- **Day 2**: User & Permission Management + Access Control Matrix  
- **Day 3**: Service Management (Apache)  
- **Day 4**: SSH Hardening + File Transfer Policy  
- **Day 5**: Backup Automation + Metadata Tagging  
- **Day 6**: Logging/Auditing + Data Quality Report  
- **Day 7**: STIG Compliance + Governance Dashboard

---

## Daily Steps

### Day 1: Base System Setup
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git net-tools vim htop unzip openssh-server
mkdir ~/backups ~/scripts
uname -a > ~/system_info.txt
df -h >> ~/system_info.txt
free -h >> ~/system_info.txt
```

---

### Day 2: User & Permission Management
**Systems Admin**
```bash
sudo addgroup dodsupport
sudo useradd -m -s /bin/bash -G dodsupport sysadmin1
sudo passwd sysadmin1
sudo usermod -aG sudo sysadmin1
sudo chage -M 90 sysadmin1
```

**Data Governance**
```bash
sudo groupadd datateam
sudo groupadd analytics
sudo mkdir -p /data/engineering /data/analytics
sudo chown :datateam /data/engineering
sudo chown :analytics /data/analytics
sudo chmod 770 /data/engineering
sudo chmod 750 /data/analytics
vim ~/data_governance/data_access_matrix.csv
```

---

### Day 3: Apache Service
```bash
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
curl http://localhost
echo "<h1>Apache Running</h1>" | sudo tee /var/www/html/index.html
sudo journalctl -u apache2 --since today
```

---

### Day 4: SSH Hardening
```bash
sudo apt install ufw -y
sudo ufw allow 22
sudo ufw enable
sudo vim /etc/ssh/sshd_config
# Set: PermitRootLogin no, AllowUsers sysadmin1
sudo systemctl restart ssh
```

**Data Governance**
```bash
sudo auditctl -w /data/engineering -p wa
sudo auditctl -w /data/analytics -p r
vim ~/data_governance/file_transfer_policy.md
```

---

### Day 5: Backup + Metadata
**Admin**
```bash
vim ~/scripts/backup.sh
chmod +x ~/scripts/backup.sh
crontab -e
# Add: 0 2 * * * /home/youruser/scripts/backup.sh
```

**Governance**
```bash
echo "Owner: DataGovTeam, Sensitivity: Internal" >> ~/backups/home_backup_$(date +%F).metadata
```

---

### Day 6: Audit + Data Quality
```bash
sudo apt install auditd -y
sudo systemctl enable auditd
sudo systemctl start auditd
sudo auditctl -w /etc/passwd -p wa
sudo ausearch -f /etc/passwd
```

**Governance**
```bash
vim ~/scripts/data_quality.sh
# Script: find /data -type f -size 0
chmod +x ~/scripts/data_quality.sh
```

---

### Day 7: STIG Compliance
```bash
sudo apt install libopenscap8 -y
sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_standard --results scan_results.xml --report scan_report.html /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml
```

**Governance**
```bash
vim ~/data_governance/report.md
```
