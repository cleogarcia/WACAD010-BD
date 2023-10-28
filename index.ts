import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

/*async function main(){//cadastro cliente
    const cliente = await prisma.cliente.create({
        data:{
               
                nomeCompleto:'WACAD010',
                cpf:'53254401245',               
        },
    }) 
}*/

/*async function main(){//update
    const updatecliente = await prisma.cliente.update({
        where: {
            idCliente: '64ad3253-4ffd-456c-8d09-8a45fe286daa',  
        },
        data:{
            nomeCompleto:'BANCO DE DADOS',
        },
    }) 
}*/

/*async function main(){// consulta
    const cliente = await prisma.cliente.findUnique({
        where:{
                idCliente:'64ad3253-4ffd-456c-8d09-8a45fe286daa', 
        },
    }) 
console.log(cliente)
}*/

async function main(){// delete
    const deletecliente = await prisma.cliente.delete({
        where:{
            idCliente:'64ad3253-4ffd-456c-8d09-8a45fe286daa', 
        },
    }) 
}

//obs: ter cuidado para não apagar tudo rsrs
/*async function main(){// deleteMany
    const deleteManycliente = await prisma.cliente.deleteMany({
        where:{
            idCliente:'2mmm', 
        },
    }) 
}*/


main()
.then(async ()=>{
    await prisma.$disconnect()
})
.catch(async(e)=>{
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
})