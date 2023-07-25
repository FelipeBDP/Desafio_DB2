-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS oficina DEFAULT CHARACTER SET utf8 ;
USE oficina ;

-- -----------------------------------------------------
-- Table oficina.Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.Cliente (
  idCliente INT NOT NULL,
  nomeCliente VARCHAR(45) NOT NULL,
  CPF VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NULL,
  PRIMARY KEY (idCliente))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.Oficina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.Oficina (
  idOficina INT NOT NULL,

  endereco VARCHAR(45) NULL,
  PRIMARY KEY (idOficina),
  UNIQUE INDEX idOficina_UNIQUE (idOficina ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.OficinaCliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.OficinaCliente (
  Oficina_idOficina INT NOT NULL,
  Cliente_idCliente INT NOT NULL,
  PRIMARY KEY (Oficina_idOficina, Cliente_idCliente),
  INDEX fk_Oficina_has_Cliente_Cliente1_idx (Cliente_idCliente ASC) VISIBLE,
  INDEX fk_Oficina_has_Cliente_Oficina_idx (Oficina_idOficina ASC) VISIBLE,
  CONSTRAINT fk_Oficina_has_Cliente_Oficina
    FOREIGN KEY (Oficina_idOficina)
    REFERENCES oficina.Oficina (idOficina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Oficina_has_Cliente_Cliente1
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES oficina.Cliente (idCliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.OrdemServico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.OrdemServico (
  idOrdemServico INT NOT NULL,
  problema VARCHAR(45) NOT NULL,
  Oficina_idOficina INT NOT NULL,
  autorizacao VARCHAR(45) NOT NULL,
  dataEntrega DATE NULL,
  PRIMARY KEY (idOrdemServico, Oficina_idOficina),
  UNIQUE INDEX idOrdemServico_UNIQUE (idOrdemServico ASC) VISIBLE,
  INDEX fk_OrdemServico_Oficina1_idx (Oficina_idOficina ASC) VISIBLE,
  CONSTRAINT fk_OrdemServico_Oficina1
    FOREIGN KEY (Oficina_idOficina)
    REFERENCES oficina.Oficina (idOficina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.Servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.Servico (
  idServico INT NOT NULL,
  descricaoServico VARCHAR(45) NOT NULL,
  OrdemServico_idOrdemServico INT NOT NULL,
  valorServico DECIMAL(7) NULL,
  PRIMARY KEY (idServico, OrdemServico_idOrdemServico),
  UNIQUE INDEX idServico_UNIQUE (idServico ASC) VISIBLE,
  INDEX fk_Servico_OrdemServico1_idx (OrdemServico_idOrdemServico ASC) VISIBLE,
  CONSTRAINT fk_Servico_OrdemServico1
    FOREIGN KEY (OrdemServico_idOrdemServico)
    REFERENCES oficina.OrdemServico (idOrdemServico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.Mecanicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.Mecanicos (
  idMecanicos INT NOT NULL,
  especialidade VARCHAR(45) NOT NULL,
  nomeMecanico VARCHAR(45) NOT NULL,
  disponibilidade VARCHAR(45) NULL,
  PRIMARY KEY (idMecanicos),
  UNIQUE INDEX idMecanicos_UNIQUE (idMecanicos ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.ServicoMecanicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.ServicoMecanicos (
  Servico_idServico INT NOT NULL,
  Mecanicos_idMecanicos INT NOT NULL,
  PRIMARY KEY (Servico_idServico, Mecanicos_idMecanicos),
  INDEX fk_Servico_has_Mecanicos_Mecanicos1_idx (Mecanicos_idMecanicos ASC) VISIBLE,
  INDEX fk_Servico_has_Mecanicos_Servico1_idx (Servico_idServico ASC) VISIBLE,
  CONSTRAINT fk_Servico_has_Mecanicos_Servico1
    FOREIGN KEY (Servico_idServico)
    REFERENCES oficina.Servico (idServico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Servico_has_Mecanicos_Mecanicos1
    FOREIGN KEY (Mecanicos_idMecanicos)
    REFERENCES oficina.Mecanicos (idMecanicos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.Pecas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.Pecas (
  idPecas INT NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  marca VARCHAR(45) NOT NULL,
  descricao VARCHAR(45) NULL,
  PRIMARY KEY (idPecas))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.PecasOrdemServico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS oficina.PecasOrdemServico (
  Pecas_idPecas INT NOT NULL,
  OrdemServico_idOrdemServico INT NOT NULL,
  PRIMARY KEY (Pecas_idPecas, OrdemServico_idOrdemServico),
  INDEX fk_Pecas_has_OrdemServico_OrdemServico1_idx (OrdemServico_idOrdemServico ASC) VISIBLE,
  INDEX fk_Pecas_has_OrdemServico_Pecas1_idx (Pecas_idPecas ASC) VISIBLE,
  CONSTRAINT fk_Pecas_has_OrdemServico_Pecas1
    FOREIGN KEY (Pecas_idPecas)
    REFERENCES oficina.Pecas (idPecas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pecas_has_OrdemServico_OrdemServico1
    FOREIGN KEY (OrdemServico_idOrdemServico)
    REFERENCES oficina.OrdemServico (idOrdemServico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;