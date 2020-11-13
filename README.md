# Boti News

Veja atualizações dos seus colegas e também do grupo Boticário.

## Getting Started

O app vem com os seguintes usuários pré-cadastrados:
- jose@teste.com.br      senha: 123456
- claudia@teste.com.br   senha: senha123
- marcondes@teste.com.br senha: Tobias000

Caso queira testar em diversos tamanhos de tela, altere o valor da seguinte variavel do arquivo [main.dart](lib/main.dart#L5):

``final releaseMode = true;`` para ``final releaseMode = false;``

Para verificar a cobertura de testes unitários, execute o arquivo [gen_coverage.sh](gen_coverage.sh) na raiz do projeto. O script irá gerar o arquivo **coverage/html/index.html**. 

Obs.: É necessário ter instalado o **lcov**
