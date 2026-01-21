ALTER TABLE beginner.socios
  ADD CONSTRAINT cnpj_basico_fk
  FOREIGN KEY (cnpj_basico) REFERENCES beginner.empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;