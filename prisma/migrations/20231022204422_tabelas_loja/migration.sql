/*
  Warnings:

  - The primary key for the `produto` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `produto` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `produto` table. All the data in the column will be lost.
  - You are about to drop the column `preco` on the `produto` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[nomeProduto]` on the table `produto` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[modeloProduto]` on the table `produto` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `categoriaIdCategoria` to the `produto` table without a default value. This is not possible if the table is not empty.
  - The required column `idProduto` was added to the `produto` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `modeloProduto` to the `produto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nomeProduto` to the `produto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `precoBase` to the `produto` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX `produto_nome_key` ON `produto`;

-- AlterTable
ALTER TABLE `produto` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    DROP COLUMN `nome`,
    DROP COLUMN `preco`,
    ADD COLUMN `categoriaIdCategoria` CHAR(40) NOT NULL,
    ADD COLUMN `idProduto` CHAR(40) NOT NULL,
    ADD COLUMN `modeloProduto` VARCHAR(100) NOT NULL,
    ADD COLUMN `nomeProduto` VARCHAR(100) NOT NULL,
    ADD COLUMN `precoBase` DECIMAL(9, 2) NOT NULL,
    ADD PRIMARY KEY (`idProduto`);

-- CreateTable
CREATE TABLE `cliente` (
    `idCliente` CHAR(40) NOT NULL,
    `nomeCompleto` VARCHAR(100) NOT NULL,
    `cpf` VARCHAR(11) NOT NULL,
    `datNasc` DATETIME(3) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`idCliente`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `endereco` (
    `idEndereco` CHAR(40) NOT NULL,
    `endCompleto` VARCHAR(200) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `clienteIdCliente` CHAR(40) NOT NULL,

    PRIMARY KEY (`idEndereco`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `compra` (
    `idCompra` CHAR(40) NOT NULL,
    `valorCompra` DECIMAL(9, 2) NOT NULL,
    `formapag` DECIMAL(9, 2) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `clienteIdCliente` CHAR(40) NOT NULL,
    `enderecoIdEndereco` CHAR(40) NOT NULL,

    PRIMARY KEY (`idCompra`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `itemProduto` (
    `idItem` CHAR(40) NOT NULL,
    `qtdeItem` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `compraIdCompra` CHAR(40) NOT NULL,
    `produtoIdProduto` CHAR(40) NOT NULL,

    PRIMARY KEY (`idItem`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categoria` (
    `idCategoria` CHAR(40) NOT NULL,
    `nomeCategoria` VARCHAR(100) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `categoria_nomeCategoria_key`(`nomeCategoria`),
    PRIMARY KEY (`idCategoria`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subcategoria` (
    `nomeCategoria` VARCHAR(100) NOT NULL,
    `DescricaoCategoria` VARCHAR(100) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `categoriaIdCategoria` CHAR(40) NOT NULL,

    UNIQUE INDEX `subcategoria_nomeCategoria_key`(`nomeCategoria`),
    UNIQUE INDEX `subcategoria_DescricaoCategoria_key`(`DescricaoCategoria`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `numserie` (
    `numserie` VARCHAR(100) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `produtoIdProduto` CHAR(40) NOT NULL,

    UNIQUE INDEX `numserie_numserie_key`(`numserie`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `produto_nomeProduto_key` ON `produto`(`nomeProduto`);

-- CreateIndex
CREATE UNIQUE INDEX `produto_modeloProduto_key` ON `produto`(`modeloProduto`);

-- AddForeignKey
ALTER TABLE `endereco` ADD CONSTRAINT `endereco_clienteIdCliente_fkey` FOREIGN KEY (`clienteIdCliente`) REFERENCES `cliente`(`idCliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `compra` ADD CONSTRAINT `compra_clienteIdCliente_fkey` FOREIGN KEY (`clienteIdCliente`) REFERENCES `cliente`(`idCliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `compra` ADD CONSTRAINT `compra_enderecoIdEndereco_fkey` FOREIGN KEY (`enderecoIdEndereco`) REFERENCES `endereco`(`idEndereco`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `itemProduto` ADD CONSTRAINT `itemProduto_compraIdCompra_fkey` FOREIGN KEY (`compraIdCompra`) REFERENCES `compra`(`idCompra`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `itemProduto` ADD CONSTRAINT `itemProduto_produtoIdProduto_fkey` FOREIGN KEY (`produtoIdProduto`) REFERENCES `produto`(`idProduto`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `produto` ADD CONSTRAINT `produto_categoriaIdCategoria_fkey` FOREIGN KEY (`categoriaIdCategoria`) REFERENCES `categoria`(`idCategoria`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subcategoria` ADD CONSTRAINT `subcategoria_categoriaIdCategoria_fkey` FOREIGN KEY (`categoriaIdCategoria`) REFERENCES `categoria`(`idCategoria`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `numserie` ADD CONSTRAINT `numserie_produtoIdProduto_fkey` FOREIGN KEY (`produtoIdProduto`) REFERENCES `produto`(`idProduto`) ON DELETE RESTRICT ON UPDATE CASCADE;
