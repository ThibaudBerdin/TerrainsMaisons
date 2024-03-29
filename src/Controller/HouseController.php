<?php

namespace App\Controller;

use App\Entity\House;
use App\Entity\Upload\Picture;
use App\Form\HouseType;
use App\Form\House\HouseSearchType;
use App\Repository\HouseRepository;
use App\Service\FileUploader;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;


#[Route('/cc/house')]
class HouseController extends AbstractController
{
    /**
     * @Route("/", name="house_index", methods={"GET", "POST"})
     * @param Request $request
     * @param HouseRepository $houseRepository
     * @return Response
     */
    public function index(Request $request, HouseRepository $houseRepository): Response
    {
        $searchForm = $this->createForm(HouseSearchType::class);
        $searchForm->handleRequest($request);


        if ($searchForm->isSubmitted() && $searchForm->isValid()) {
            $dataAll = $searchForm->getData();

            $model = $houseRepository->searchByName($dataAll);
        } else {
            $model = $houseRepository->findBy([], ['name'=>'ASC']);
        }

        return $this->render('house/index.html.twig', [
            'houses' => $model,
            'form' => $searchForm->createView(),
        ]);
    }


    /**
     * @Route("/new", name="house_new", methods={"GET","POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @param FileUploader $fileUploader
     * @return Response
     */
    public function new(Request $request, FileUploader $fileUploader): Response
    {
        $house = new House();
        $form = $this->createForm(HouseType::class, $house);
        $form->handleRequest($request);


        if ($form->isSubmitted() && $form->isValid()) {

            //Gestion Pictures
            $picturesFile = $form->get('pictures')->getData();
            foreach ($picturesFile as $picture) {

                $pict = new Picture();
                $pict->setName($fileUploader->uploadPicture($picture));
                $house->addPicture($pict);
            }

            //Gestion Plans
            $planFile = $form->get('uploadPlan')->getData();
            if($planFile){
                $planFileName = $fileUploader->upload($planFile);
                $house->setPlanFilename($planFileName);
            }
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($house);
            $entityManager->flush();

            return $this->redirectToRoute('house_index');
        }

        return $this->render('house/new.html.twig', [
            'house' => $house,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/delete/picture/{id}", name="house_delete_picture", methods={"DELETE"})
     *
     */
    public function deletePicture(Picture $picture, Request $request, FileUploader $fileUploader){
        $data = json_decode($request->getContent(), true);

        // On vérifie si le token est valide
        if($this->isCsrfTokenValid('delete'.$picture->getId(), $data['_token'])){
            // On récupère le chemin de l'image
            $picturePath = $picture->getName();
            // On supprime le fichier
            $fileUploader->deletePicture($picturePath);

            // On supprime l'entrée de la base
            $em = $this->getDoctrine()->getManager();
            $em->remove($picture);
            $em->flush();


            // On répond en json
            return $this->json(['success' => 1], 200);
        }

        return $this->json(['error' => 'Token Invalide'], 400);
    }

    /**
     * @Route("/{id}", name="house_show", methods={"GET"})
     */
    public function show(House $house): Response
    {
        return $this->render('house/show.html.twig', [
            'house' => $house,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="house_edit", methods={"GET","POST"})
     * @param Request $request
     * @param House $house
     * @param FileUploader $fileUploader
     * @return Response
     */
    public function edit(Request $request, House $house, FileUploader $fileUploader): Response
    {
        $form = $this->createForm(HouseType::class, $house);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            //Gestion Pictures
            $picturesFile = $form->get('pictures')->getData();
            foreach ($picturesFile as $picture) {

                $pict = new Picture();
                $pict->setName($fileUploader->uploadPicture($picture));
                $house->addPicture($pict);
            }



            //Recupere les liens des fichiers
            $planFile = $form->get('uploadPlan')->getData();
            $currentPlanFile = $house->getPlanFilename();
            $deleteFile = $form->get('deleteFile')->getData();

            //Supprimer un Plan Existant
            if($deleteFile && $currentPlanFile)
            {
                $fileUploader->delete($currentPlanFile);
                $house->setPlanFilename(null);
            }

            //Traitement des fichiers
            if($planFile !== $currentPlanFile && $planFile){
                $planFileName = $fileUploader->upload($planFile);
                if($currentPlanFile){
                    $fileUploader->delete($house->getPlanFilename());
                }
                $house->setPlanFilename($planFileName);
            }
            //Sauvegarde en DB
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('house_index');
        }

        return $this->render('house/edit.html.twig', [
            'house' => $house,
            'form' => $form->createView(),
        ]);
    }



    /**
     * @Route("/{id}", name="house_delete", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @param House $house
     * @param FileUploader $fileUploader
     * @return Response
     */
    public function delete(Request $request, House $house, FileUploader $fileUploader): Response
    {
        if ($this->isCsrfTokenValid('delete' . $house->getId(), $request->request->get('_token'))) {
            $file = $house->getPlanFilename();
            $filePictures = $house->getPictures();

            foreach ($filePictures as $filePicture) {
                $fileUploader->deletePicture($filePicture->getName());
            }

            if($file)
            {
                $fileUploader->delete($file);
            }

            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($house);
            $entityManager->flush();
        }


        return $this->redirectToRoute('house_index');
    }
}
