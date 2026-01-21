ALTER TABLE beginner.empresas
    ADD CONSTRAINT cnpj_basico_unique
    UNIQUE (cnpj_basico);

ALTER TABLE beginner.empresas
  ADD CONSTRAINT natureza_juridica_fk
  FOREIGN KEY (natureza_juridica) REFERENCES beginner.naturezas (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;