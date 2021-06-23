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

### ДЗ №9. Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform

**Выполнено:**
1. Основное задание:
  * Один большой файл `main.tf` разбит на модули
  * Инраструтура разделена на окружения `dev` и `prod`
  * Модули параметризованы

2. Доп. задание:
  * Добавлены provisioner'ы для деплоя приложения
  * Настроен экспорт переменной `DATABASE_URL` в инстанс с приложением для подключения к базе MongoDB
  * Отредактирован конфиг MongoDB на принятие запросов на локальный IP адрес в приватной сети Yandex Cloud
  * Доступ к приложению по внешнему IP адресу протестирован

### ДЗ №10. Управление конфигурацией. Основные DevOps инструменты. Знакомство с Ansible

**Выполнено:**
1. Основное задание:
  * Созданы два файла `inventory` в `txt` и `yml` форматах
  * Кофигурация ansible для проекта описана в файле `ansible.cfg`
  * Написан простой плейбук `clone.yml` по клонированию приложения из github а сервер

### ДЗ №11. Деплой и управление конфигурацией с Ansible

**Выполнено:**
1. Основное задание:
  * Один большой плейбук по конфигурации инфраструктуры разбит на три: `db.yml`, `app.yml`, `deploy.yml` - эти плейбуки импоритуются в плейбук `site.yml`
  * Bash-скрипты в провиженинге Packer'а заменены плейбуками `packer_app.yml` и `packer_db.yml`, созданы новые образы
2. Доп. задание:
  * Написан bash-скрипт `inventory.sh` для формирования динамического inventory, скрипт добавлен в `ansible.cfg` в качестве дефолтного inventory
