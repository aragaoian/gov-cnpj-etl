ALTER TABLE socios
  ADD CONSTRAINT cnpj_completo_unique
  UNIQUE (cnpj_basico, nome_socio);

ALTER TABLE socios
  ADD CONSTRAINT cnpj_basico_fk
  FOREIGN KEY (cnpj_basico) REFERENCES empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE socios
  ADD CONSTRAINT qualificacao_socio_fk
  FOREIGN KEY (qualificacao_socio) REFERENCES qualificacoes (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE socios
  ADD CONSTRAINT qualificao_representante_fk
  FOREIGN KEY (qualificao_representante) REFERENCES qualificacoes (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE socios
  ADD CONSTRAINT paises_fk
  FOREIGN KEY (pais) REFERENCES paises (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;