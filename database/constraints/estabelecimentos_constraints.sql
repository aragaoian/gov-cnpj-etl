ALTER TABLE estabelecimentos
    ADD CONSTRAINT cnpj_unique
    UNIQUE (cnpj_basico, cnpj_ordem, cnpj_dv);

ALTER TABLE estabelecimentos
  ADD CONSTRAINT cnpj_basico_fk
  FOREIGN KEY (cnpj_basico) REFERENCES empresas (cnpj_basico)
  ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE estabelecimentos
    ADD CONSTRAINT pais_fk
    FOREIGN KEY (pais) REFERENCES paises (codigo)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE estabelecimentos
    ADD CONSTRAINT cnae_principal_fk
    FOREIGN KEY (cnae_fiscal_principal) REFERENCES cnaes (codigo)
    ON DELETE RESTRICT ON UPDATE CASCADE;
  
ALTER TABLE estabelecimentos
    ADD CONSTRAINT cnae_secundaria_fk
    FOREIGN KEY (cnae_fiscal_secundaria) REFERENCES cnaes (codigo)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE estabelecimentos
  ADD CONSTRAINT municipio_fk
  FOREIGN KEY (municipio) REFERENCES municipios (codigo)
  ON DELETE RESTRICT ON UPDATE CASCADE;