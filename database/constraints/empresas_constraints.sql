ALTER TABLE empresas
    ADD CONSTRAINT cnpj_basico_unique
    UNIQUE (cnpj_basico);

ALTER TABLE empresas
  ADD CONSTRAINT natureza_juridica_fk
  FOREIGN KEY (natureza_juridica) REFERENCES naturezas (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE empresas
  ADD CONSTRAINT qualificacao_responsavel_fk
  FOREIGN KEY (qualificacao_responsavel) REFERENCES qualificacoes (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;