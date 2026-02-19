ALTER TABLE d_simples
  ADD CONSTRAINT cnpj_basico_d__unique
  UNIQUE (cnpj_basico);

ALTER TABLE d_simples
  ADD CONSTRAINT cnpj_basico_simples_fk
  FOREIGN KEY (cnpj_basico) REFERENCES empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;