# Atividade Aws e Linux

Repositório para realizar a atividade de linux e AWS do programa de bolsas da compass UOL.

**Descrição da parte de AWS**: Gerar uma chave pública para acesso ao ambiente, criar uma instância EC2 com o sistema operacional Amazon linux 2 (Família t3.small,
16 GB SSD), gerar 1 elastic IP e anexar à instância EC2, liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP).

**Descrição da parte de Linux**: Configurar o NFS entregue, criar um diretorio dentro do filesystem do NFS com seu nome, subir um apache no servidor, criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs, O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline, o script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE, preparar a execução automatizada do script a cada 5 minutos

---
## Requisitos

### Configurações para Instancia AWS:
- Gerar uma chave pública para acessar o ambiente
- Criar instancia com sistema operacional Amazon linux 2
  - Familia t3.small 
  - Volume 16GB SSD
- Gerar 1 Elastic IP e associar a instacia
- Liberar portas de comunicação para acesso público
   - 22/TCP (SSH)
   - 111/TCP e UDP (RPC)
   - 2049/TCP/UDP (NFS)
   - 80/TCP (HTTP)
   - 443/TCP (HTTPS)
   
### Configurações para o linux:
- Configurar o NFS entregue
- Criar um diretorio dentro do filesystem do NFS com seu nome
- Subir um apache no servidor - o apache deve estar online e rodando
- Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs
  - O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline
  - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE
  - Preparar a execução automatizada do script a cada 5 minutos

