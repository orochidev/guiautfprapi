# GuiaUTFPR API

## Sobre


Uma API desenvolvida por [mim](http://www.victormatheus.com.br) na época que lancei o aplicativo **Guia UTFPR** há muito tempo atrás. Serve para fornecer os dados disponíveis no portal do aluno. A API acessa o portal com o login/senha informados, extrai todas as informações e fornece pra você todas elas em JSON que pode ser consumido por qualquer tipo de aplicação.

Resolvi jogar o código aqui neste repositório para que posteriormente alguém possa utilizar para desenvolver algum app bacana. Atualmente a API está disponível e rodando em um plano free do Heroku e pode ser consumida através do link https://guiautfprapi.herokuapp.com/.

## URL e versionamento

Como diria [Renata Vasconcelos](https://www.youtube.com/watch?v=B1tupT3LijM), a manutenção dada a este código é simplesmente **"Chocha, capenga, manca, anêmica, frágil e inconsistente"**.
Pretendo adicionar mais algumas rotas para facilitar o consumo das informações ainda nesta versão V1 ( https://guiautfprapi.herokuapp.com/v1 ), porém a intenção é que haja uma grande refatoração na migração para a V2, eliminando más práticas graves de desenvolvimento que foram se acumulando durante o tempo de existência deste código ( acredito que tem uns 2 anos que esse código não há alteraçoẽs neste código ~~porém funciona~~ ).


## Rotas

https://guiautfprapi.herokuapp.com/v1/disciplinas_matriculadas?campus=campo_mourao

Espera um Basic HTTP Auth no cabeçalho com RA e senha do aluno. O parâmetro **campus** também espera o nome do campus ao qual o aluno pertence. Basta escrever o nome do campus e, caso haja espaço, separe por _ (underline).

Retorna:
```javascript
{
    "disciplinas": [
        {
            "codigo": "",
            "nome": "",
            "codigo_turma": "",
            "faltas": "",
            "media_parcial": "",
            "aulas_dadas": "",
            "cch_prevista": "",
            "pct_frequencia": "",
            "media_final": "",
            "situacao": ""
        },
        ...
    ]
}
```
https://guiautfprapi.herokuapp.com/v1/dados_portal?campus=campo_mourao

Espera um Basic HTTP Auth no cabeçalho com RA e senha do aluno. O parâmetro **campus** também espera o nome do campus ao qual o aluno pertence. Basta escrever o nome do campus e, caso haja espaço, separe por _ (underline).

Retorna os dados de algumas páginas disponíveis no Portal do Aluno.
```javascript

{
    "pagina_inicial": {
        "RA": "",
        "nome": "",
        "nome_curso": "",
        "situacao_curso": "",
        "linha": "",
        "curscodnr": "",
        "tpcurcodnr": "",
        "alcuordemnr": ""
    },
    "declaracao_matricula": {
        "nome": "",
        "ra": "",
        "nome_curso": "",
        "carga_horaria": "",
        "duracao": "",
        "regime_ensino": "",
        "ingresso": "",
        "periodo": "",
        "semestre": "",
        "turno": "",
        "inicio_semestre": "",
        "termino_semestre": "",
        "dias_letivos": "",
        "estagio": ""
    },
    "disciplinas_matricladas": [
        {
            "codigo": "M1",
            "inicio": "07h30",
            "termino": "08h20",
            "aula_segunda": {
                "codigo_disciplina": "",
                "codigo_turma": "",
                "sala": ""
            },
            "aula_terca":{
                "codigo_disciplina": "",
                "codigo_turma": "",
                "sala": ""
            },
            "aula_quarta": {
                "codigo_disciplina": "",
                "codigo_turma": "",
                "sala": ""
            },
            "aula_quinta": {
                "codigo_disciplina": "",
                "codigo_turma": "",
                "sala": ""
            },
            "aula_sexta": {
                "codigo_disciplina": "",
                "codigo_turma": "",
                "sala": ""
            },
            "aula_sabado": {
                "codigo_disciplina": "",
                "codigo_turma": "",
                "sala": ""
            }
        }...
       
       
    ],
    "boletim": {
        "disciplinas": [
            {
                "codigo": "",
                "nome": "",
                "codigo_turma": "",
                "faltas": "",
                "media_parcial": "",
                "aulas_dadas": "",
                "cch_prevista": "",
                "pct_frequencia": "",
                "media_final": "",
                "situacao": ""
            }...
        ]
    }
}
```
