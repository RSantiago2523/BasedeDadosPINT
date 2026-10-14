/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2017                    */
/* Created on:     05/12/2024 11:15:00                          */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('AREA')
            and   type = 'U')
   drop table AREA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ASSINCRONO')
            and   type = 'U')
   drop table ASSINCRONO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AVALIACOES')
            and   type = 'U')
   drop table AVALIACOES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATEGORIA')
            and   type = 'U')
   drop table CATEGORIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CONTEUDOS')
            and   type = 'U')
   drop table CONTEUDOS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CONTEUDOS_PARTILHADO')
            and   type = 'U')
   drop table CONTEUDOS_PARTILHADO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CURSOS')
            and   type = 'U')
   drop table CURSOS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DENUNCIA')
            and   type = 'U')
   drop table DENUNCIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FORMADORES')
            and   type = 'U')
   drop table FORMADORES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FORMANDOS')
            and   type = 'U')
   drop table FORMANDOS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GESTOR_ADMINISTRADOR')
            and   type = 'U')
   drop table GESTOR_ADMINISTRADOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INSCRICOES')
            and   type = 'U')
   drop table INSCRICOES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('OCORRENCIAS_EDICOES')
            and   type = 'U')
   drop table OCORRENCIAS_EDICOES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SINCRONO')
            and   type = 'U')
   drop table SINCRONO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPO_FORMATO')
            and   type = 'U')
   drop table TIPO_FORMATO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOPICO')
            and   type = 'U')
   drop table TOPICO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UTILIZADOR')
            and   type = 'U')
   drop table UTILIZADOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VARIAS')
            and   type = 'U')
   drop table VARIAS
go

/*==============================================================*/
/* Table: CATEGORIA                                             */
/*==============================================================*/
create table CATEGORIA (
   ID_CATEGORIA         int                  not null,
   NOME_CAT             text                 null,
   DESCRICAO_CAT        text                 null,
   constraint PK_CATEGORIA primary key (ID_CATEGORIA)
)
go

/*==============================================================*/
/* Table: AREA                                                  */
/*==============================================================*/
create table AREA (
   ID_AREA              int                  not null,
   ID_CATEGORIA         int                  not null,
   NOME_AREA            text                 null,
   DESCRICAO_AR         text                 null,
   constraint PK_AREA primary key (ID_AREA),
   constraint FK_AREA_ADQUIRE_CATEGORI foreign key (ID_CATEGORIA)
      references CATEGORIA (ID_CATEGORIA)
)
go

/*==============================================================*/
/* Table: TOPICO                                                */
/*==============================================================*/
create table TOPICO (
   ID_TOPICO            int                  not null,
   ID_AREA              int                  not null,
   NOME_TOPICO          text                 null,
   DESCRICAO_TOP        text                 null,
   constraint PK_TOPICO primary key (ID_TOPICO),
   constraint FK_TOPICO_CONTAM_AREA foreign key (ID_AREA)
      references AREA (ID_AREA)
)
go

/*==============================================================*/
/* Table: UTILIZADOR                                            */
/*==============================================================*/
create table UTILIZADOR (
   ID_UTILIZADOR        int                  not null,
   NOME_UTILIZADOR      text                 null,
   EMAIL                text                 null,
   PASSWORD             text                 null,
   PERFIL               text                 null,
   DATA_CRIACAO_UTILIZ  datetime             null,
   constraint PK_UTILIZADOR primary key (ID_UTILIZADOR)
)
go

/*==============================================================*/
/* Table: GESTOR_ADMINISTRADOR                                  */
/*==============================================================*/
create table GESTOR_ADMINISTRADOR (
   ID_UTILIZADOR        int                  not null,
   ID_GESTOR_ADMINISTRADOR int                  not null,
   NOME_UTILIZADOR      text                 null,
   EMAIL                text                 null,
   PASSWORD             text                 null,
   PERFIL               text                 null,
   DATA_CRIACAO_UTILIZ  datetime             null,
   constraint PK_GESTOR_ADMINISTRADOR primary key (ID_UTILIZADOR, ID_GESTOR_ADMINISTRADOR),
   constraint FK_GESTOR_A_PODE_SER2_UTILIZAD foreign key (ID_UTILIZADOR)
      references UTILIZADOR (ID_UTILIZADOR)
)
go

/*==============================================================*/
/* Table: CURSOS                                                */
/*==============================================================*/
create table CURSOS (
   ID_CURSO             int                  not null,
   ID_TOPICO            int                  not null,
   ID_UTILIZADOR        int                  not null,
   ID_GESTOR_ADMINISTRADOR int                  not null,
   ID_CATEGORIA         int                  not null,
   ID_AREA              int                  not null,
   NOME_CURSO           text                 null,
   DESCRICAO_CURSO      text                 null,
   NUMERO_VAGAS         int                  null,
   DATA_INICIO_CURSO    datetime             null,
   DATA_FIM             datetime             null,
   TIPO_CURSO           int                  null,
   ESTADO               int                  null,
   constraint PK_CURSOS primary key (ID_CURSO),
   constraint FK_CURSOS_TEM_CATEGORI foreign key (ID_CATEGORIA)
      references CATEGORIA (ID_CATEGORIA),
   constraint FK_CURSOS_POSSUI_AREA foreign key (ID_AREA)
      references AREA (ID_AREA),
   constraint FK_CURSOS_CONTA_TOPICO foreign key (ID_TOPICO)
      references TOPICO (ID_TOPICO),
   constraint FK_CURSOS_CRIA_GESTOR_A foreign key (ID_UTILIZADOR, ID_GESTOR_ADMINISTRADOR)
      references GESTOR_ADMINISTRADOR (ID_UTILIZADOR, ID_GESTOR_ADMINISTRADOR)
)
go

/*==============================================================*/
/* Table: ASSINCRONO                                            */
/*==============================================================*/
create table ASSINCRONO (
   ID_CURSO             int                  not null,
   ID_CURSO_ASSINCRONO  int                  not null,
   ID_TOPICO            int                  null,
   ID_GESTOR_ADMINISTRADOR int                  null,
   ID_CATEGORIA         int                  null,
   ID_AREA              int                  null,
   NOME_CURSO           text                 null,
   DESCRICAO_CURSO      text                 null,
   NUMERO_VAGAS         int                  null,
   DATA_INICIO_CURSO    datetime             null,
   DATA_FIM             datetime             null,
   TIPO_CURSO           int                  null,
   ESTADO               int                  null,
   constraint PK_ASSINCRONO primary key (ID_CURSO, ID_CURSO_ASSINCRONO),
   constraint FK_ASSINCRO_PODEM_SER_CURSOS foreign key (ID_CURSO)
      references CURSOS (ID_CURSO)
)
go

/*==============================================================*/
/* Table: CONTEUDOS_PARTILHADO                                  */
/*==============================================================*/
create table CONTEUDOS_PARTILHADO (
   ID_AREA_CONHECIMENTO int                  not null,
   ID_AREA              int                  not null,
   ID_TOPICO            int                  not null,
   ID_CATEGORIA         int                  not null,
   ID_UTILIZADOR        int                  not null,
   NOME_CP              text                 null,
   DESCRICAO_CP         text                 null,
   DATA_CRIACAO_CP      datetime             null,
   constraint PK_CONTEUDOS_PARTILHADO primary key (ID_AREA_CONHECIMENTO),
   constraint FK_CONTEUDO_CRIAR_UTILIZAD foreign key (ID_UTILIZADOR)
      references UTILIZADOR (ID_UTILIZADOR),
   constraint FK_CONTEUDO_DETEM_TOPICO foreign key (ID_TOPICO)
      references TOPICO (ID_TOPICO),
   constraint FK_CONTEUDO_INCLUI_AREA foreign key (ID_AREA)
      references AREA (ID_AREA),
   constraint FK_CONTEUDO_CONTEM_CATEGORI foreign key (ID_CATEGORIA)
      references CATEGORIA (ID_CATEGORIA)
)
go

/*==============================================================*/
/* Table: AVALIACOES                                            */
/*==============================================================*/
create table AVALIACOES (
   ID_AVALIACAO         int                  not null,
   ID_AREA_CONHECIMENTO int                  not null,
   ID_UTILIZADOR        int                  not null,
   constraint PK_AVALIACOES primary key (ID_AVALIACAO),
   constraint FK_AVALIACO_FAZER_UTILIZAD foreign key (ID_UTILIZADOR)
      references UTILIZADOR (ID_UTILIZADOR),
   constraint FK_AVALIACO_EXISTEM_CONTEUDO foreign key (ID_AREA_CONHECIMENTO)
      references CONTEUDOS_PARTILHADO (ID_AREA_CONHECIMENTO)
)
go

/*==============================================================*/
/* Table: TIPO_FORMATO                                          */
/*==============================================================*/
create table TIPO_FORMATO (
   ID_FORMATO           int                  not null,
   URL                  varchar(100)         null,
   FICHEIRO             varchar(50)          null,
   VIDEO                varchar(50)          null,
   constraint PK_TIPO_FORMATO primary key (ID_FORMATO),
)
go

/*==============================================================*/
/* Table: CONTEUDOS                                             */
/*==============================================================*/
create table CONTEUDOS (
   ID_CONTEUDO          int                  not null,
   ID_CURSO             int                  not null,
   ID_FORMATO           int                  not null,
   CONTEUDO             text                 null,
   constraint PK_CONTEUDOS primary key (ID_CONTEUDO),
   constraint FK_CONTEUDO_TEM_DISPO_CURSOS foreign key (ID_CURSO)
      references CURSOS (ID_CURSO),
   constraint FK_CONTEUDO_REUNE_TIPO_FOR foreign key (ID_FORMATO)
      references TIPO_FORMATO (ID_FORMATO)
)
go

/*==============================================================*/
/* Table: DENUNCIA                                              */
/*==============================================================*/
create table DENUNCIA (
   ID_DENUNCIA          int                  not null,
   ID_UTILIZADOR        int                  null,
   ID_AREA_CONHECIMENTO int                  not null,
   constraint PK_DENUNCIA primary key (ID_DENUNCIA),
   constraint FK_DENUNCIA_REALIZA_UTILIZAD foreign key (ID_UTILIZADOR)
      references UTILIZADOR (ID_UTILIZADOR),
   constraint FK_DENUNCIA_PERTENCE_CONTEUDO foreign key (ID_AREA_CONHECIMENTO)
      references CONTEUDOS_PARTILHADO (ID_AREA_CONHECIMENTO)
)
go

/*==============================================================*/
/* Table: FORMADORES                                            */
/*==============================================================*/
create table FORMADORES (
   ID_UTILIZADOR        int                  not null,
   ID_FORMADOR          int                  not null,
   NOME_UTILIZADOR      text                 null,
   EMAIL                text                 null,
   PASSWORD             text                 null,
   PERFIL               text                 null,
   DATA_CRIACAO_UTILIZ  datetime             null,
   ESPECIALIDADES       text                 null,
   EXPERIENCIA          text                 null,
   constraint PK_FORMADORES primary key (ID_UTILIZADOR, ID_FORMADOR),
   constraint FK_FORMADOR_PODE_SER3_UTILIZAD foreign key (ID_UTILIZADOR)
      references UTILIZADOR (ID_UTILIZADOR)
)
go

/*==============================================================*/
/* Table: FORMANDOS                                             */
/*==============================================================*/
create table FORMANDOS (
   ID_UTILIZADOR        int                  not null,
   ID_FORMANDO          int                  not null,
   NOME_UTILIZADOR      text                 null,
   EMAIL                text                 null,
   PASSWORD             text                 null,
   PERFIL               text                 null,
   DATA_CRIACAO_UTILIZ  datetime             null,
   PERCURSO_FORMATIVO   text                 null,
   constraint PK_FORMANDOS primary key (ID_UTILIZADOR, ID_FORMANDO),
   constraint FK_FORMANDO_PODE_SER_UTILIZAD foreign key (ID_UTILIZADOR)
      references UTILIZADOR (ID_UTILIZADOR)
)
go

/*==============================================================*/
/* Table: INSCRICOES                                            */
/*==============================================================*/
create table INSCRICOES (
   ID_INSCRICAO         int                  not null,
   ID_UTILIZADOR        int                  not null,
   ID_FORMANDO          int                  not null,
   ID_CURSO             int                  not null,
   DATA_LIMITE          datetime             null,
   DATA_INICIO_INSC     datetime             null,
   STATUS_INSCRICAO     int                  null,
   constraint PK_INSCRICOES primary key (ID_INSCRICAO),
   constraint FK_INSCRICO_DETERMINA_CURSOS foreign key (ID_CURSO)
      references CURSOS (ID_CURSO),
   constraint FK_INSCRICO_REALIZAM_FORMANDO foreign key (ID_UTILIZADOR, ID_FORMANDO)
      references FORMANDOS (ID_UTILIZADOR, ID_FORMANDO)
)
go

/*==============================================================*/
/* Table: OCORRENCIAS_EDICOES                                   */
/*==============================================================*/
create table OCORRENCIAS_EDICOES (
   NR_OCORRENCIA        int                  not null,
   constraint PK_OCORRENCIAS_EDICOES primary key (NR_OCORRENCIA)
)
go

/*==============================================================*/
/* Table: SINCRONO                                              */
/*==============================================================*/
create table SINCRONO (
   ID_CURSO             int                  not null,
   ID_CURSO_SINCRONO    int                  not null,
   ID_UTILIZADOR        int                  not null,
   ID_FORMADOR          int                  not null,
   ID_TOPICO            int                  null,
   ID_GESTOR_ADMINISTRADOR int                  null,
   ID_CATEGORIA         int                  null,
   ID_AREA              int                  null,
   NOME_CURSO           text                 null,
   DESCRICAO_CURSO      text                 null,
   NUMERO_VAGAS         int                  null,
   DATA_INICIO_CURSO    datetime             null,
   DATA_FIM             datetime             null,
   TIPO_CURSO           int                  null,
   ESTADO               int                  null,
   constraint PK_SINCRONO primary key (ID_CURSO, ID_CURSO_SINCRONO),
   constraint FK_SINCRONO_LECIONAM_FORMADOR foreign key (ID_UTILIZADOR, ID_FORMADOR)
      references FORMADORES (ID_UTILIZADOR, ID_FORMADOR),
   constraint FK_SINCRONO_PODEM_SER_CURSOS foreign key (ID_CURSO)
      references CURSOS (ID_CURSO)
)
go

/*==============================================================*/
/* Table: VARIAS                                                */
/*==============================================================*/
create table VARIAS (
   ID_CONTEUDO          int                  not null,
   NR_OCORRENCIA        int                  not null,
   constraint PK_VARIAS primary key (ID_CONTEUDO, NR_OCORRENCIA),
   constraint FK_VARIAS_VARIAS_CONTEUDO foreign key (ID_CONTEUDO)
      references CONTEUDOS (ID_CONTEUDO),
   constraint FK_VARIAS_VARIAS2_OCORRENC foreign key (NR_OCORRENCIA)
      references OCORRENCIAS_EDICOES (NR_OCORRENCIA)
)
go

