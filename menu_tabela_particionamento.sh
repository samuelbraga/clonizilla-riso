#!/bin/bash
#------------------------------------------------------
# Autor: Raylander Fróis Lopes <raylanderlopes@hotmail.com>
#
#------------------------------------------------------
# Função exibe os discos rigidos disponiveis e cria
# a tabela de particionamento do disco.
#------------------------------------------------------
# Histórico:
# v1.0 2016-06-09, Raylander Fróis Lopes:
#  - Versao Inicial
#
function menu_tabela_particionamento(){
  source $CLONEZILLA/carregar_discos.sh
  
  local discos_rigidos=(carrergar_discos)
  local entradas_menu=""
  for disco in $discos_rigidos
  do
	local entradas_menu="$entradas_menu /dev/$disco /dev/$disco"
  done
  while : ; do
    opcao=$(dialog --stdout                   \
    --no-tags                                 \
    --title "Discos Rigidos"                  \
    --ok-label "Confirmar"                    \
    --cancel-label "Cancelar"                 \
    --menu "Escolha um Disco:"                \
    0 0 0                                     \
    $entradas_menu                            \
    )
    if [ -z $opcao ]; then
        break
    else
    	 nome_tabela=$(dialog --stdout --inputbox 'Digite o nome para a tabela de particionamento:' 0 0)
    	 sfdisk -d $opcao > $DIR_TABELA$nome_tabela
    	 break
    fi
done
}
