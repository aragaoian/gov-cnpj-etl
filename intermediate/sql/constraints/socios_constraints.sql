-- This table does not have any natural primary keys
-- So, there is no way to identify the identity of the column
-- therefore making it impossible to update entrie reliably

ALTER TABLE d_socios
  ADD CONSTRAINT cnpj_basico_socios_fk
  FOREIGN KEY (cnpj_basico) REFERENCES empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE d_socios
  ADD CONSTRAINT qualificacao_socio_fk
  FOREIGN KEY (qualificacao_socio) REFERENCES qualificacoes (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE d_socios
  ADD CONSTRAINT qualificao_representante_fk
  FOREIGN KEY (qualificao_representante) REFERENCES qualificacoes (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE d_socios
  ADD CONSTRAINT paises_fk
  FOREIGN KEY (pais) REFERENCES paises (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;