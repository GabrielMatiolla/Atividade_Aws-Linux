# Atividade Aws e Linux

Repositório para realizar a atividade de linux e AWS do programa de bolsas da compass UOL.

**Descrição da parte de AWS**: Gerar uma chave pública para acesso ao ambiente, criar uma instância EC2 com o sistema operacional Amazon linux 2 (Família t3.small,
16 GB SSD), gerar 1 elastic IP e anexar à instância EC2, liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP,
2049/TCP/UDP, 80/TCP, 443/TCP).

**Descrição da parte de Linux**: Configurar o NFS entregue, criar um diretorio dentro do filesystem do NFS com seu nome, subir um apache no servidor, criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs, O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline, o script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE, preparar a execução automatizada do script a cada 5 minutos

---
## Requisitos AWS

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
---
## Instruções passo a passo AWS

### Gerar uma chave pública e uma instância EC2 e anexar a chave pública a instância criada.
- Abrir o console da AWS no serviço de EC2 e clicar em "Pares de chaves" no menu a esquerda.
- Clicar em "Criar pares de chaves".
- Colocar um nome na chave e clicar em "Criar par de chaves".
- Salvar o arquivo .pem em uma pasta segura.
- Clicar em "instâncias" no menu esquerdo.
- Clicar em "Executar instâncias".
- Selecionar a imagem Amazon Linux 2 AMI, SSD volume type.
- Selecionar o tipo de instância t3.small.
- Selecionar a chave que foi gerada posteriormente
- Selecionar 16 GB de armazenamento gp2 (SSD).
- Clicar em "Executar instância"

### Configurar gateway de internet.

- Acessar a AWS na pagina do serviço VPC, e clicar em "Gateways de internet" no menu a esquerda.
- Clicar em "Criar gateway de internet".
- Definir um nome para o gateway e clicar em "Criar gateway de internet".
- Selecionar o gateway criado e clicar em "Ações" > "Associar à VPC".
- Selecionar a VPC da instância EC2 criada anteriormente e clicar em "Associar".

### Criar e Alocar um endereço IP elástico a instância EC2.

- Abrir o console da AWS no serviço de EC2 e clicar em "IPs elásticos" no menu a esquerda.
- Clicar em "Alocar endereço IP elástico".
- Deixar as configurações como estão e clicar em "alocar" 
- Selecionar o ip alocado e clicar em "Ações" > "Associar endereço IP elástico".
- Selecionar a instância criada anteriormente e clicar em "Associar".

### Configurações de rota de internet.

- Acessar a AWS na pagina do serviço VPC, e clicar em "Tabelas de rotas" no menu lateral esquerdo.
- Selecionar a tabela de rotas da VPC da instância EC2 criada anteriormente.
- Clicar em "Ações" > "Editar rotas".
- Clicar em "Adicionar rota".
- Configurar da seguinte forma:
    - Destino: 0.0.0.0/0
    - Alvo: Selecionar o gateway de internet criado anteriormente
- Clicar em "Salvar alterações".

### Configurações de regras de segurança.

- Abrir o console da AWS no serviço de EC2 e clicar em "Segurança" > "Grupos de segurança" no menu a esquerda.
- Selecionar o grupo de segurança da instância criada anteriormente.
- Clicar em "Editar regras de segurança".
- Configurar as regras:
    Tipo | Protocolo | Intervalo de portas | Origem | Descrição
    ---|---|---|---|---
    SSH | TCP | 22 | 0.0.0.0/0 | SSH
    TCP personalizado | TCP | 443 | 0.0.0.0/0 | HTTPS
    TCP personalizado | TCP | 80 | 0.0.0.0/0 | HTTP
    UDP personalizado | UDP | 111 | 0.0.0.0/0 | RPC
    TCP personalizado | TCP | 111 | 0.0.0.0/0 | RPC
    UDP personalizado | UDP | 2049 | 0.0.0.0/0 | NFS
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 | NFS
    
## Requisitos Linux
 
### Configurar o NFS entregue;
 - Navegue até o serviço EFS
 - Clique em "Criar sistema de arquivos"
 - Atribua um nome, caso queira, e clique em "Criar"
 - Clique no ID do sistema de arquivos ao qual deseja criar um ponto de montagem.
 - Na guia "Ponto de acesso", clique no botão "Criar ponto de acesso", defina um nome, caso deseje, e clique em "Criar ponto de acesso".
 - Na guia "Rede", clique em "Gerenciar", e atribua o security group criado anteriormente às subnets disponíveis.
 - Com tudo configurado, deve-se anotar o "Nome de DNS" do sistema de arquivos
 - Ao logar à instância por meio de ssh, deve-se criar o diretório /mnt/nfs
 - Depois deve-se montar o sistema de arquivos, por meio do comando ``` sudo mount -t nfs4 <DNS_Name>:/ /mnt/nfs ```
 - Para automatizar a montagem, deve-se instalar o driver do Amazon EFS: ```sudo yum install amazon-efs-utils -y```
 - Depois, deve-se editar o arquivo /etc/fstab, inserindo a seguinte linha: ```<DNS_Name>:/ /mnt/nfs efs defaults,_netdev 0 0```
    
    
