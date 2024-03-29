<?php

namespace App\Entity\Land;

use App\Entity\Admin\House\HouseRoofing;
use App\Entity\Admin\Tag;
use App\Entity\Contact\Contact;
use App\Repository\Land\AllotmentRepository;
use DateTime;
use DateTimeInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\String\Slugger\SluggerInterface;

/**
 * @ORM\Entity(repositoryClass=AllotmentRepository::class)
 * @ORM\HasLifecycleCallbacks()
 */
#[UniqueEntity(
    fields: ['name', 'city', 'postalCode'],
    message: 'Il existe deja une combinaison nom + ville + code postal'
)]
class Allotment
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="allotment_id", initialValue=1000)
     * @ORM\Column(type="integer")
     */
    private int $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private ?string $name;

    /**
     * @ORM\Column(type="string")
     */
    private ?string $postalCode;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private ?string $city;

    /**
     * @ORM\Column(type="datetime")
     */
    private ?DateTimeInterface $createdAt;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private ?DateTimeInterface $updatedAt;

    /**
     * @ORM\OneToMany(targetEntity=Plot::class, mappedBy="allotment", orphanRemoval=true, cascade={"persist"})
     */
    private $plots;

    /**
     * @ORM\ManyToMany(targetEntity=Contact::class, inversedBy="allotments")
     */
    private $contacts;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private float $propertyLimit;

    /**
     * @ORM\Column(type="boolean")
     */
    private $doubleLimit;

    /**
     * @ORM\ManyToMany(targetEntity=HouseRoofing::class)
     */
    private $houseRoofings;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $localUrbanPlanFile;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $regulationFile;

    /**
     * @ORM\Column(type="boolean")
     */
    private $isValid;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $allotmentPlanFile;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $notaryFees;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $description;

    /**
     * @ORM\ManyToOne(targetEntity=AllotmentState::class, inversedBy="allotments")
     */
    private $state;

    /**
     * @ORM\ManyToMany(targetEntity=Tag::class)
     */
    private $tags;

    /**
     * @ORM\ManyToOne(targetEntity=Sanitation::class, inversedBy="allotments")
     */
    private $sanitation;

    /**
     * @ORM\Column(type="string", length=255, unique=true)
     */
    private $slug;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $latitude;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $longitude;

    public function __construct()
    {
        $this->plots = new ArrayCollection();
        $this->contacts = new ArrayCollection();
        $this->houseRoofings = new ArrayCollection();
        $this->tags = new ArrayCollection();
    }

    public function __toString(): string
    {
    return $this->getName();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getPostalCode(): ?string
    {
        return $this->postalCode;
    }

    public function setPostalCode(string $postalCode): self
    {
        $this->postalCode = $postalCode;

        return $this;
    }

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(string $city): self
    {
        $this->city = $city;

        return $this;
    }

    public function getCreatedAt(): ?DateTimeInterface
    {
        return $this->createdAt;
    }

    /**
     * @ORM\PrePersist
     * @return $this
     */
    public function setCreatedAt(): self
    {
        $this->createdAt = new DateTime('now');

        return $this;
    }

    public function getUpdatedAt(): ?DateTimeInterface
    {
        return $this->updatedAt;
    }

    /**
     * @ORM\PreUpdate
     * @return $this
     */
    public function setUpdatedAt(): self
    {
        $this->updatedAt = new DateTime('now');

        return $this;
    }

    /**
     * @return Collection|Plot[]
     */
    public function getPlots(): Collection
    {
        return $this->plots;
    }

    public function addPlot(Plot $plot): self
    {
        if (!$this->plots->contains($plot)) {
            $this->plots[] = $plot;
            $plot->setAllotment($this);
        }

        return $this;
    }

    public function removePlot(Plot $plot): self
    {
        if ($this->plots->removeElement($plot)) {
            // set the owning side to null (unless already changed)
            if ($plot->getAllotment() === $this) {
                $plot->setAllotment(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection|Contact[]
     */
    public function getContacts(): Collection
    {
        return $this->contacts;
    }

    public function addContact(Contact $contact): self
    {
        if (!$this->contacts->contains($contact)) {
            $this->contacts[] = $contact;
        }

        return $this;
    }

    public function removeContact(Contact $contact): self
    {
        $this->contacts->removeElement($contact);

        return $this;
    }

    /**
     * @return float
     */
    public function getPropertyLimit(): float
    {
       if(!$this->propertyLimit) {
           return $this->propertyLimit = 0;
       }
       return $this->propertyLimit;
    }

    public function setPropertyLimit(float $propertyLimit): self
    {
        $this->propertyLimit = $propertyLimit;

        return $this;
    }

    public function getDoubleLimit(): ?bool
    {
        return $this->doubleLimit;
    }

    public function setDoubleLimit(bool $doubleLimit): self
    {
        $this->doubleLimit = $doubleLimit;

        return $this;
    }


    /**
     * @return Collection|HouseRoofing[]
     */
    public function getHouseRoofings(): Collection
    {
        return $this->houseRoofings;
    }

    public function addHouseRoofing(HouseRoofing $houseRoofing): self
    {
        if (!$this->houseRoofings->contains($houseRoofing)) {
            $this->houseRoofings[] = $houseRoofing;
        }

        return $this;
    }

    public function removeHouseRoofing(HouseRoofing $houseRoofing): self
    {
        $this->houseRoofings->removeElement($houseRoofing);

        return $this;
    }

    public function getLocalUrbanPlanFile(): ?string
    {
        return $this->localUrbanPlanFile;
    }

    public function setLocalUrbanPlanFile(?string $localUrbanPlanFile): self
    {
        $this->localUrbanPlanFile = $localUrbanPlanFile;

        return $this;
    }

    public function getRegulationFile(): ?string
    {
        return $this->regulationFile;
    }

    public function setRegulationFile(?string $regulationFile): self
    {
        $this->regulationFile = $regulationFile;

        return $this;
    }

    // Fonctions Personnalisees

    public function getMinPriceAtiPlot():string
    {
        $priceMin = [];
        $plots = $this->getPlots();
        foreach ($plots as $plot ){
            $price = $plot->getSellingPriceAti();
            $priceMin[] = $price;
        }
        if($priceMin){
           $rMin = min($priceMin);
           return number_format($rMin,0,'.', ' ') . ' €' ;
        }
        return "____";
    }

    public function getIsValid(): ?bool
    {
        return $this->isValid;
    }

    public function setIsValid(bool $isValid): self
    {
        $this->isValid = $isValid;

        return $this;
    }

    public function getAllotmentPlanFile(): ?string
    {
        return $this->allotmentPlanFile;
    }

    public function setAllotmentPlanFile(?string $allotmentPlanFile): self
    {
        $this->allotmentPlanFile = $allotmentPlanFile;

        return $this;
    }

    public function getNotaryFees(): ?float
    {
        return $this->notaryFees;
    }

    public function setNotaryFees(?float $notaryFees): self
    {
        $this->notaryFees = $notaryFees;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getState(): ?AllotmentState
    {
        return $this->state;
    }

    public function setState(?AllotmentState $state): self
    {
        $this->state = $state;

        return $this;
    }

    /**
     * @return Collection|Tag[]
     */
    public function getTags(): Collection
    {
        return $this->tags;
    }

    public function addTag(Tag $tag): self
    {
        if (!$this->tags->contains($tag)) {
            $this->tags[] = $tag;
        }

        return $this;
    }

    public function removeTag(Tag $tag): self
    {
        $this->tags->removeElement($tag);

        return $this;
    }

    public function getSanitation(): ?Sanitation
    {
        return $this->sanitation;
    }

    public function setSanitation(?Sanitation $sanitation): self
    {
        $this->sanitation = $sanitation;

        return $this;
    }

    public function getSlug(): ?string
    {
        return $this->slug;
    }

    public function setSlug(string $slug): self
    {
        $this->slug = $slug;

        return $this;
    }

    //Compter les terrains libres pour affichage sur page accueil
    public function getPlotFree(){
        $plots = $this->getPlots();
        $plotsFree = [];

        foreach ($plots as $plot) {

            if($plot->getState()->getName() === "Libre"){
                $plotsFree[] = $plot;
            }
        }
        return count($plotsFree);
    }


    //Mise a jour du Slug
    public function computeSlug(SluggerInterface $slugger): void
    {
        if (!$this->slug || '-' === $this->slug){
            $this->slug = (string) $slugger->slug
            ((string) $this->getCity() .'-'. $this->getName() .'-'.
                $this->getPostalCode())->lower();
        }
    }

    public function getLatitude(): ?float
    {
        return $this->latitude;
    }

    public function setLatitude(float $latitude): self
    {
        $this->latitude = $latitude;

        return $this;
    }

    public function getLongitude(): ?float
    {
        return $this->longitude;
    }

    public function setLongitude(?float $longitude): self
    {
        $this->longitude = $longitude;

        return $this;
    }




    }
