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
