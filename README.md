# Manual de criação do pendrive bootável do Clonezilla com clonezilla-riso
## Manual de criação do pendrive bootável do Clonezilla

- Baixe o [arquivo zip](http://clonezilla.org/downloads.php) Clonezilla.

- Para a criação de seu pendrive, é necessário que ele seja divido em duas partições. A primeira com pelo menos 300MB formatada com FAT16 ou FAT32, e a segunda formatada com EXT4. Você pode usar qualquer ferramenta de particionamento (por exemplo: gparted, parted, fdisk, cfdisk ou sfdisk). Para continuar é necessário saber o nome de sua unidade USB (exemplo: /dev/sdb1). Execute o comando: 
```
$ sudo fdisk -l
```
Assim será listado o nome de sua unidade flash.
- Neste exemplo, assumimos que /dev/sdb1 tem sistema de arquivos FAT, e é automaticamente montado no dir /media/usb/. Se não for montado automaticamente, é preciso montá-lo manualmente com o comando:
 
```
$ mkdir -p /media/usb 
$ mount /dev/sdd1/media/usb/
```
- Descompacte o arquivo zip do Clonezilla em sua unidade USB. Você pode fazer isso com o comando:
 
```
$ unzip clonezilla-live-X.Y.Z-W-amd64.zip -d /media/usb/ 
```
- Para que sua unidade USB se torne bootável, primeiro entre na pasta "utils/linux" no diretório criado:
```
$ cd /media/usb/utils/linux
```
Em seguida, execute 
```
$ sudo bash makeboot.sh /dev/sdb1
```
Substitua /dev/sdb1 com o nome do dispositivo USB flash, e siga as instruções. Poderá aparecer o seguinte erro:

`On x86-64 system, you should install libc6-i386 (for Debian/Ubuntu) or glibc.i686 (for Fedora/CentOS/OpenSuSE) package so that the required libraries to run 32-bit program /tmp/syslinux_tmp.JeNRrE/syslinux exist.`

Está solicitando a instalação do libc6-i386 no sistema. Caso esteja executando uma distribuição baseada em Debian, então basta executar o comando:
```
sudo apt-get install libc6-i386
```
Agora poderá repetir o comando anterior, seguir as instruções e seu pendrive bootável com o Clonezilla estará pronto.

## Manual de criação do Clonezilla modificado com script do clonezilla-riso

Para o processo de adição de script é necessário que os passos de criação do pendrive bootavel com o Clonezilla seja concluido. 

- Crie seu script e certifique-se de que a primeira linha no seu script seja a shebang (#!/bin/bash) para evitar um problema de "erro de formato", vamos usar como exemplo o script "clonezilla-riso.sh".

- Dê boot no pendrive e entre no "prompt command", se não for um usuario root execute o comando:
```
$ sudo su
```

- Monte a segunda partição do pendrive em algum diretorio de trabalho, como "/home/partimag". Você pode usar o comando: 
```
$ mkdir -p /home/patimag
$ mount /dev/sdb2 /home/partimag 
```
Assim, irá usar /dev/sdb2 como o dir trabalho.

- Copie o script "clonezilla-riso.sh" para o diretorio criado "/home/partimag".Para a copia do arquivo (se estiver no HD) será preciso montar seu HD para ter acesso aos arquivos. Use o comando:
```
$ fdisk -l
```
Será listado no caminho de seu HD ou unidades flash. Vamos assumir que o nome encontrado do HD é "/dev/sda1". Agora é necessário monta-lo em algum lugar, iremos ultilizar o caminho "/mnt". Execute o seguinte comando para monta-lo:
```
$ mkdir -p /mnt
$ mount /dev/sda1 /mnt
```
Seu HD foi montado. Agora é preciso entrar no endereço "/mnt" e procurar a pasta onde seu script foi salvo. Dentro da pasta do script execute o comando para copia-lo para o diretorio criado anteriormente:
```
$ cp clonezilla-script.sh /home/partimag
```
- Execute o seguinte comando e será gerado um arquivo zip modificado com adição de seu script "clonezilla-riso.sh, e será salvo na segunda partição de seu pendrive.
```
$ cd /home/partimag
$ ocs-live-dev -g en_US.UTF-8 -k NONE -s -c -m ./clonezilla-riso.sh
```
- Agora é somente seguir o "Manual de criação do pendrive bootável do Clonezilla", substituindo o arquivo zip a ser baixado pelo novo zip gerado e salvo na segunda partição USB.

