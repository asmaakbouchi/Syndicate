create database Gestion_Coproprietaire
use Gestion_Coproprietaire
create table Droit(
ID_Droit int auto_increment primary key,
Libelle varchar(100) not null unique
)
select*from payement
µinsert into Droit(Libelle) values ('- Afficher la liste des copropriétaires '),
(' - Paramétrage de la fiche résidence '),(' - Gestion des compte copropriétaires '),
('- Gestion des comptes Mandataires '),('- Gestion des comptes Syndics '),
(' - Modification de la liste des droits '),(' - Consultation Journal de caisse '),
(' - Gestion Encaissement '),(' - Gestion de decaissement '),
('- Gestion de Fournisseurs ')
create table Users(
IdUser int primary key auto_increment ,
Nom Nvarchar(20) not null,
Prenom Nvarchar(20) not null ,
Tel varchar(20) not null,
Adresse nvarchar(40),
Email Nvarchar(40) unique not null,
MotDePass Nvarchar(15) not null,
TypeUser varchar(15),
check(TypeUser='ADMIN' or 'SYNDIC' or 'COPROPRIETAIRE' or 'MANDATAIRE'),
Statut nvarchar(15),
check(Statut='Actif'or'Bloqué'),
Genre varchar(10) not null ,
check(Genre='Femme'or'homme'),
Date_Inscription date
)
insert into Users (Nom,Prenom,Tel,Adresse,Email,MotDePass,TypeUser,Statut,
Genre) values ('kouraik','nabila','06_57_39_78_93','CASABLANCA,Hay Anassi','kouraiknabila06@gmail.com','NaKo@2022',
'ADMIN','Actif','Femme')
create table Droit_Utilisateur(
id  int auto_increment primary key ,
ID_Droit int,
foreign key (ID_Droit) references Droit(ID_Droit),
IdUser int,
foreign key (IdUser) references Users(IdUser),
Statut Nvarchar(40),
check(Statut='Autorisation complète' or 'Autorisation Affichage' or 'pas Autorisé')
)
create table Fiche_Residence(
IdRes int primary key auto_increment,
Nom_Residence nvarchar(15) not null,
Nbr_immeuble int not null ,
IdUser int,
foreign key (IdUser) references Users(IdUser),
MontantFix float not null
)
create table Immeuble (
Numero_Immeuble int auto_increment primary key ,
Nom_Immeuble nvarchar(15) not null ,
Nbr_Etages int not null,
idRes int,
foreign key (IdRes)  references Fiche_Residence (IdRes),
IdUser int,
foreign key (IdUser) references Users(IdUser)
)
create table Etage(
Numero_etage int primary key,
nbr_Localité int not null
)
create table Localite (
id_localite int  auto_increment primary key ,
Ref_Localite nvarchar(40),
Type_localite varchar(30),
check(Type_localite='Appartement' or 'Magasin' or 'Plateau Bureau' or 'Duplex'),
IdUser int,
 Numero_etage int,
 foreign key (Numero_etage) references Etage(Numero_etage),
foreign key (IdUser) references Users(IdUser),
Num_Localite int unique not null,
PU float not null 
)
create table Coproprietaire (
Idcop int  auto_increment primary key,
IdUser int,
foreign key (IdUser) references Users(IdUser),
id_localite int,
foreign key (id_localite)  references Localite(id_localite),
Date_1er_Cotisation  date default (curdate()),
Periodicite varchar(15),
check(Periodicite='annuel' or 'mensuel' or 'trimestriel'),
Montant float not null
)
create table Mandataire(
Id_Mandataire int  auto_increment primary key,
Idcop int,
foreign key (Idcop) references Coproprietaire(Idcop),
IdUser int,
foreign key (IdUser) references Users(IdUser)
)
create table Facture(
Numero_Facturex int  auto_increment primary key,
Montant float not null,
Motif text not null,
Reste_Facture float ,
Statut boolean default false,
IdUser int,
foreign key (IdUser) references Users(IdUser)
)
create table Encaissement(
Id_Encaissement int  auto_increment primary key,
Type_Payement varchar(15),
check(Type_Payement='Espèce' or 'Chèque' or 'Carte' or 'Virement'),
Montant float not null ,
Idcop int,
foreign key (Idcop) references Coproprietaire(Idcop),
Numero_Facture int,
foreign key (Numero_Facture) references Facture(Numero_Facture),
Statut boolean
)
create table Ligne_Facture(
id int  auto_increment primary key,
Numero_Facture int,
foreign key (Numero_Facture) references Facture(Numero_Facture),
Id_Encaissement int,
foreign key (Id_Encaissement) references Encaissement(Id_Encaissement)
)
create table Decaissement(
idDecaissement int  auto_increment primary key,
Idcop int,
foreign key (Idcop) references Coproprietaire(Idcop),
IdUser int,
foreign key (IdUser) references Users(IdUser),
Date_Decaissement date default(curdate()),
Libelle text not null,
Piece_Jointe blob ,
Montant float not null,
Num_Facture int unique not null,
Nom_Responsable nvarchar(30),
Prenom_Responsable nvarchar(30)
) 
select*from Decaissement
alter table Decaissement add Nom_Responsable nvarchar(30)
alter table Decaissement add Prenom_Responsable nvarchar(30)

Create table Fournisseur (
Id_Four int auto_increment primary key ,
Rs  varchar(40) not null,
Tel int not null,
Nom varchar(25) not null,
Prenom varchar(25) not null,
Email varchar(30) not null
)
alter table Fournisseur add Adresse nvarchar(40)

create table Validation_Inscription(
Id_V int auto_increment primary key,
IdUser int,
foreign key (IdUser) references Users(IdUser),
Date_Validation date default (curdate()),
Statut varchar(15),
check(Statut='En attent 'or'Validé')
)
CREATE table Contact (
Id_contact int primary key auto_increment,
NomComplet nvarchar(50) not null,
Email nvarchar(30) not null,
Objet text not null,
Telephone varchar(16),
Message text not null
)



create table Offres(
id_Offre int primary key auto_increment,
Nom_Offre nvarchar(50) not null,
Nbr_Localite int not null,
prix_Mois varchar(10) not null
)
insert into Offres (Nom_Offre,Nbr_Localite,prix_Mois) 
values ('Essentiel',20,'100DH'),('Bénévol',50,'250DH'),('Professionnel',100,'500DH'),
('business',200,'1000DH'),('Premium',500,'2500DH')





