   SELECT * FROM crime_scene_report where city='SQL City'and type='murder'
   
   
   --Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".
   
   
      SELECT * FROM person where name like 'Annabel%'and address_street_name='Franklin Ave'              


--16371	Annabel Miller	490173	103	Franklin Ave	318771143

--90081	16371	Annabel Miller	20160208 gold

--I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

--14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949


--SELECT * FROM interview where address_street_name ='Northwestern Dr'

