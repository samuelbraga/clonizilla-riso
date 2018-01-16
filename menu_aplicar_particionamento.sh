#!/bin/bash
# Autor: Raylander Fróis Lopes <raylanderlopes@hotmail.com>
#
#------------------------------------------------------
# Função para aplicar a tabela de particionamento ao
# disco rigido escolhido.
#------------------------------------------------------
# Histórico:
# v1.0 2016-06-08, Raylander Frois Lopes
#   - Versão inicial.  
##v1.2 2016-06-23, Samuel Fantini:
#   - Modularização das funções
#
function menu_aplicar_particionamento(){
  source $CLONEZILLA/carregar_discos.sh 
  
  arquivo_particionamento=$DIR_PARTICIONAMENTO$1
  
  local discos_rigidos=(carrergar_discos)
  local entradas_menu=""
  for disco in $discos_rigidos
  do
	local entradas_menu="$entradas_menu /dev/$disco /dev/$disco"
  done
  while : ; do
    opcao=$(dialog --stdout                   \
    --no-tags                                 \
    --title "Menu aplicar particionamento"    \
    --ok-label "Confirmar"                    \
    --cancel-label "Cancelar"                 \
    --menu "Escolha um Disco:"                \
    0 0 0                                     \
    $entradas_menu                           \
    )
    if [ -z $opcao ]; then
        break
    else
        sfdisk $opcao < $arquivo_particionamento
        break
    fi
  done
}
