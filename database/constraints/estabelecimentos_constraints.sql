ALTER TABLE beginner.estabelecimentos
    ADD CONSTRAINT cnpj_unique
    UNIQUE (cnpj_basico, cnpj_ordem, cnpj_dv);

ALTER TABLE beginner.estabelecimentos
  ADD CONSTRAINT cnpj_basico_fk
  FOREIGN KEY (cnpj_basico) REFERENCES beginner.empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE beginner.estabelecimentos
    ADD CONSTRAINT pais_fk
    FOREIGN KEY (pais) REFERENCES beginner.paises (codigo)
    ON DELETE RESTRICT ON UPDATE CASCADE;