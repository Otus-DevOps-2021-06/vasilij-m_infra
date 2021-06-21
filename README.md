# vasilij-m_infra
vasilij-m Infra repository

### Подключение к *someinternalhost* одной командой:

ssh -J appuser@<bastion_public_ip> appuser@<someinternalhost_private_ip>

### Вариант подключения вида `ssh someinternalhost`:

В файл `~/.ssh/config` нужно добавить следующие строки:

```
Host bastion
    HostName <bastion_public_ip>
    User appuser
    IdentityFile <private_ssh_key_location_for_yacloud>
Host someinternalhost
    HostName someinternalhost
    ProxyJump bastion
    User appuser
```

### Pritunl-OVPN

```
bastion_IP = 178.154.254.98
someinternalhost_IP = 10.128.0.18
```

### cloud-testapp

```
testapp_IP = 178.154.201.109
testapp_port = 9292
```

**Команда для создания инстанса с запущенным приложением:**

```
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--metadata-from-file user-data=./metadata.yml
```

### ДЗ №7. Сборка образов VM при помощи Packer

**Выполнено:**
* Основное задание с параметризацией шаблона
* Доп. задание "Построение bake-образа" с запуском приложения с помощью systemd юнита
* Доп. задание "Автоматизация создания ВМ"

### ДЗ №8. Практика IaC с использованием Terraform

**Выполнено:**
1. Основное задание:
  * Виртуальная машина описана в `main.tf`
  * Выодные переменные описаны в `outputs.tf`
  * Входные переменные параметризированы в `variables.tf` и `terraform.tfvars`

2. Доп. задание:
  * Описан балансировщик в `lb.tf`
  * В `outputs.tf` добавлен IP адрес балансировщика
  * Описано создание двух экземляров виртуальных машин в `main.tf` через параметр `count`
