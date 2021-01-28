<?php

namespace App\Repository\Matching;

use App\Entity\Matching\PlotHouseMatching;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method PlotHouseMatching|null find($id, $lockMode = null, $lockVersion = null)
 * @method PlotHouseMatching|null findOneBy(array $criteria, array $orderBy = null)
 * @method PlotHouseMatching[]    findAll()
 * @method PlotHouseMatching[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PlotHouseMatchingRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PlotHouseMatching::class);
    }

    public function findByHouseBedroom($plot, $bedRoom, $houseBrand, $budgetMax)
    {
        return $this->createQueryBuilder('m')
            ->join('m.house', 'h')
            ->andWhere('h.roomNumber = :bedroom')
            ->andWhere('h.houseBrand = :brand')
            ->andWhere('m.plot = :plot')
            ->andWhere('m.sellingPriceAti <= :budgetMax')
            ->setParameters([
                'plot' => $plot,
                'bedroom' => $bedRoom,
                'brand' => $houseBrand,
                'budgetMax' => $budgetMax,
            ])
            ->orderBy('m.sellingPriceAti', 'ASC')
            ->getQuery()
            ->getResult()
            ;
    }

    public function findByBudget($budget)
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.sellingPriceAti <= :budget')
            ->setParameters([
                'budget'=>$budget
            ])
            ->orderBy('m.updatedAt', 'ASC')
            ->setMaxResults(50)
            ->getQuery()
            ->getResult()
            ;
    }

    // /**
    //  * @return PlotHouseMatching[] Returns an array of PlotHouseMatching objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?PlotHouseMatching
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
