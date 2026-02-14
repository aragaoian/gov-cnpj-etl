ALTER TABLE simples
  ADD CONSTRAINT cnpj_basico_simples_unique
  UNIQUE (cnpj_basico);

ALTER TABLE simples
  ADD CONSTRAINT cnpj_basico_simples_fk
  FOREIGN KEY (cnpj_basico) REFERENCES empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;