-- -- CREATE DATABASE TABLES AND DEFINE FOREIGN KEYS

CREATE TABLE leads (
	lead_id INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100),
	phone VARCHAR(30),
	company VARCHAR(100),
	industry VARCHAR(50),
	lead_source VARCHAR(100),
	lead_status ENUM('new', 'contacted', 'qualified', 'converted', 'lost'),
	created_date DATE,
	last_contacted_date DATE
);

CREATE TABLE sales_team (
	user_id INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100),
	phone VARCHAR(30),
	department VARCHAR(100)
);

CREATE TABLE interactions (
	interaction_id INT PRIMARY KEY,
	lead_id INT,
	user_id INT,
	interaction_date DATE,
	interaction_type VARCHAR(100),
	notes VARCHAR(1000),
	FOREIGN KEY (lead_id) REFERENCES leads(lead_id) ON DELETE SET NULL,
	FOREIGN KEY (user_id) REFERENCES sales_team(user_id) ON DELETE SET NULL
);

CREATE TABLE lead_assignments (
	assignment_id INT PRIMARY KEY,
	lead_id INT,
	user_id INT,
	assignment_date DATE,
	FOREIGN KEY (lead_id) REFERENCES leads(lead_id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES sales_team(user_id) ON DELETE SET NULL
); 

CREATE TABLE opportunities (
	opportunity_id INT PRIMARY KEY,
	lead_id INT,
	product_interest VARCHAR(100),
	estimated_value INT,
	stage ENUM('prospecting', 'qualification', 'proposal', 'negotiation', 'closed'),
	initiated_by INT,
	assigned_to INT,
	FOREIGN KEY (lead_id) REFERENCES leads(lead_id) ON DELETE SET NULL,
	FOREIGN KEY (initiated_by) REFERENCES sales_team(user_id) ON DELETE SET NULL,
	FOREIGN KEY (assigned_to) REFERENCES lead_assignments(user_id) ON DELETE SET NULL
);

-- -----------------------------------------------------------------------------

-- -- INSERT DATA INTO ALL TABLES 

INSERT INTO leads VALUES 
    (99, 'Mikael', 'Wallin', 'mikael.wallin@abcinc.com', '1234567890', 'ABC Inc.', 'Technology', 'referral', 'new', '2024-02-01', '2024-05-10'),
    (100, 'Ida', 'Stromberg', 'ida.stromberg@defcorp.com', '1234567891', 'DEF Corp.', 'Healthcare', 'CDC Conference 2024', 'contacted', '2024-04-01', '2024-05-12'),
    (101, 'Jakob', 'Honkanen', 'jakob.honkanen@flexirsolutions.com', '1234567892', 'Flexir Solutions', 'Manufacturing', 'email campaign', 'lost', '2023-11-20', '2024-05-15'),
    (102, 'Lotte', 'van den Berg', 'lotte.vandenburg@hscentral.com', '1234567893', 'Highlands Central', 'Food and Beverages', 'FDB Conference 2023', 'contacted', '2023-05-02', '2024-05-10'),
    (103, 'Saara', 'Karppinen', 'saara.karppinen@flygp.com', '1234567894', 'Flygp', 'Technology', 'website', 'qualified', '2023-04-05', '2024-05-15'),
    (104, 'Ali', 'Ubegen', 'ali.ubegen@uniq.com', '1234567895', 'Uniq Inc.', 'Transportation', 'referral', 'converted', '2023-06-20', '2024-05-10'),
    (105, 'Mira', 'Lindberg', 'mira.lindberg@innovatech.com', '1234567896', 'Innovatech Solutions', 'Technology', 'trade show', 'new', '2024-02-10', '2024-05-14'),
    (106, 'Elias', 'Kallio', 'elias.kallio@swiftwares.com', '1234567897', 'SwiftWares', 'Technology', 'webinar', 'contacted', '2024-03-15', '2024-05-13'),
    (107, 'Hanna', 'Heikkila', 'hanna.heikkila@nextgen.com', '1234567898', 'NextGen Solutions', 'Technology', 'email campaign', 'new', '2024-04-20', '2024-05-11'),
    (108, 'Tero', 'Peltola', 'tero.peltola@globewide.com', '1234567899', 'Globewide Services', 'Finance', 'referral', 'contacted', '2024-01-05', '2024-05-09'),
    (109, 'Aino', 'Lahtinen', 'aino.lahtinen@transtech.net', '1234567900', 'TransTech Solutions', 'Transportation', 'website', 'qualified', '2024-05-01', '2024-05-08'),
    (110, 'Emilia', 'Koskinen', 'emilia.koskinen@techcorp.com', '1234567901', 'Tech Corp.', 'Technology', 'Tech Expo 2024', 'new', '2024-02-15', '2024-05-12'),
    (111, 'Mikael', 'Lindgren', 'mikael.lindgren@innovatech.com', '1234567902', 'InnovaTech Solutions', 'Technology', 'trade show', 'qualified', '2023-09-10', '2024-05-15'),
    (112, 'Sophia', 'Virtanen', 'sophia.virtanen@dataforge.com', '1234567903', 'DataForge', 'Technology', 'Webinar', 'contacted', '2023-08-20', '2024-05-10'),
    (113, 'Elias', 'Niemi', 'elias.niemi@medisolutions.com', '1234567904', 'MediSolutions', 'Healthcare', 'Medical Conference 2024', 'qualified', '2023-11-25', '2024-05-15'),
    (114, 'Aino', 'Korpela', 'aino.korpela@sunshinetechnologies.com', '1234567905', 'Sunshine Technologies', 'Technology', 'Webinar', 'contacted', '2024-01-02', '2024-05-10'),
    (115, 'Daniel', 'Karlsson', 'daniel.karlsson@newgen.com', '1234567906', 'NewGen Innovations', 'Technology', 'Referral', 'converted', '2023-07-15', '2024-05-15'),
    (116, 'Emma', 'Lahtinen', 'emma.lahtinen@edusystems.com', '1234567907', 'EduSystems', 'Education', 'Trade Show', 'new', '2024-03-05', '2024-05-12'),
    (117, 'Niklas', 'Koski', 'niklas.koski@advantech.com', '1234567908', 'Advantech Solutions', 'Technology', 'referral', 'contacted', '2023-10-20', '2024-05-10'),
    (118, 'Linnea', 'Peltola', 'linnea.peltola@healthysolutions.com', '1234567909', 'Healthy Solutions', 'Healthcare', 'Email Campaign', 'qualified', '2023-12-10', '2024-05-15'),
    (119, 'Eetu', 'Jokinen', 'eetu.jokinen@techtools.com', '1234567910', 'Tech Tools Ltd.', 'Technology', 'Website', 'new', '2024-01-20', '2024-05-12'),
    (120, 'Julia', 'Laine', 'julia.laine@modernminds.com', '1234567911', 'Modern Minds', 'Technology', 'Trade Show', 'contacted', '2023-09-01', '2024-05-10'),
    (121, 'Eemil', 'Lehtinen', 'eemil.lehtinen@toplineconsulting.com', '1234567912', 'Topline Consulting', 'Consulting', 'Cold Call', 'lost', '2023-10-05', '2024-05-10'),
    (122, 'Helmi', 'Kallio', 'helmi.kallio@aquacorp.com', '1234567913', 'AquaCorp Ltd.', 'Water Management', 'Trade Show', 'contacted', '2023-08-15', '2024-05-10'),
    (123, 'Aatu', 'Rinne', 'aatu.rinne@techsavvy.com', '1234567914', 'TechSavvy Solutions', 'Technology', 'Email Campaign', 'contacted', '2023-11-02', '2024-05-10'),
    (124, 'Iiris', 'Heikkinen', 'iiris.heikkinen@smartech.com', '1234567915', 'Smartech Innovations', 'Technology', 'Tech Expo 2023', 'qualified', '2023-07-10', '2024-05-15'),
    (125, 'Santeri', 'Laakso', 'santeri.laakso@brightsoft.com', '1234567916', 'BrightSoft Solutions', 'Technology', 'Referral', 'converted', '2023-06-25', '2024-05-15'),
    (126, 'Aada', 'Toivonen', 'aada.toivonen@globaltech.com', '1234567917', 'GlobalTech Solutions', 'Technology', 'Trade Show', 'contacted', '2023-08-05', '2024-05-10'),
    (127, 'Lauri', 'Mäkelä', 'lauri.makela@bigdatacorp.com', '1234567918', 'Big Data Corp.', 'Technology', 'Tech Expo 2024', 'new', '2024-02-10', '2024-05-12'),
    (128, 'Emmi', 'Koskela', 'emmi.koskela@analyticsteam.com', '1234567919', 'Analytics Team Ltd.', 'Technology', 'referral', 'new', '2024-04-05', '2024-05-12'),
    (129, 'Oliver', 'Anttila', 'oliver.anttila@techmedsolutions.com', '1234567920', 'TechMed Solutions', 'Healthcare', 'Medical Conference 2023', 'qualified', '2023-10-15', '2024-05-15'),
    (130, 'Nea', 'Tiainen', 'nea.tiainen@innovativecorp.com', '1234567921', 'Innovative Corp.', 'Technology', 'Webinar', 'new', '2024-03-15', '2024-05-12'),
    (131, 'Akseli', 'Salmi', 'akseli.salmi@infosol.com', '1234567922', 'InfoSolutions Ltd.', 'Technology', 'referral', 'contacted', '2023-09-20', '2024-05-10'),
    (132, 'Aina', 'Saari', 'aina.saari@brighterfuture.com', '1234567923', 'Brighter Future Ltd.', 'Technology', 'Referral', 'converted', '2023-07-02', '2024-05-15'),
    (133, 'Tino', 'Laitinen', 'tino.laitinen@datainsights.com', '1234567924', 'Data Insights', 'Technology', 'Webinar', 'contacted', '2024-02-15', '2024-05-10'),
    (134, 'Emma', 'Andersson', 'emma.andersson@acmecompany.com', '1234567925', 'ACME Company', 'Retail', 'Webinar', 'lost', '2024-03-15', '2024-05-10'),
    (135, 'Oscar', 'Nilsson', 'oscar.nilsson@techsolutions.com', '1234567926', 'Tech Solutions', 'Technology', 'Cold Call', 'lost', '2024-04-10', '2024-05-20'),
    (136, 'Ella', 'Lindgren', 'ella.lindgren@bigdataco.com', '1234567927', 'Big Data Co.', 'Technology', 'Trade Show', 'converted', '2024-02-28', '2024-05-18'),
    (137, 'Adam', 'Johansson', 'adam.johansson@innovatecorp.com', '1234567928', 'Innovate Corp.', 'Technology', 'Email Campaign', 'contacted', '2024-04-05', '2024-05-14'),
    (138, 'Julia', 'Eriksson', 'julia.eriksson@pharmasolutions.com', '1234567929', 'Pharma Solutions', 'Healthcare', 'Referral', 'qualified', '2024-04-20', '2024-05-16'),
    (139, 'Liam', 'Persson', 'liam.persson@globalbizinc.com', '1234567930', 'Global Biz Inc.', 'Finance', 'conference', 'contacted', '2024-04-12', '2024-05-11'),
    (140, 'Maja', 'Svensson', 'maja.svensson@medtechsolutions.com', '1234567931', 'MedTech Solutions', 'Healthcare', 'Trade Show', 'contacted', '2024-03-25', '2024-05-19'),
    (141, 'Noah', 'Larsson', 'noah.larsson@smarttechcorp.com', '1234567932', 'Smart Tech Corp.', 'Technology', 'Webinar', 'qualified', '2024-04-02', '2024-05-13'),
    (142, 'Wilma', 'Gustafsson', 'wilma.gustafsson@startupventures.com', '1234567933', 'Startup Ventures', 'Technology', 'website', 'lost', '2023-12-10', '2024-05-17'),
    (143, 'Lucas', 'Lindqvist', 'lucas.lindqvist@newhorizoninc.com', '1234567934', 'New Horizon Inc.', 'Technology', 'Email Campaign', 'new', '2024-05-02', '2024-05-15'),
    (144, 'Alice', 'Berg', 'alice.berg@logisticsgroup.com', '1234567935', 'Logistics Group', 'Logistics', 'conference', 'contacted', '2024-04-18', '2024-05-10'),
    (145, 'Elias', 'Nyström', 'elias.nystrom@energyinnovations.com', '1234567936', 'Energy Innovations', 'Energy', 'Trade Show', 'qualified', '2024-03-30', '2024-05-12'),
    (146, 'Olivia', 'Ahonen', 'olivia.ahonen@financesolutions.com', '1234567937', 'Finance Solutions', 'Finance', 'Referral', 'contacted', '2024-04-08', '2024-05-14'),
    (147, 'Liam', 'Koskinen', 'liam.koskinen@agritechgroup.com', '1234567938', 'AgriTech Group', 'Agriculture', 'Trade Show', 'new', '2024-04-25', '2024-05-18'),
    (148, 'Astrid', 'Hakala', 'astrid.hakala@globaltechinc.com', '1234567939', 'Global Tech Inc.', 'Technology', 'Website', 'contacted', '2024-04-05', '2024-05-13'),
    (149, 'Emil', 'Virtanen', 'emil.virtanen@healthcaregroup.com', '1234567940', 'Healthcare Group', 'Healthcare', 'conference', 'lost', '2023-12-05', '2024-05-16'),
    (150, 'Alva', 'Saari', 'alva.saari@smartlogistics.com', '1234567941', 'Smart Logistics', 'Logistics', 'Email Campaign', 'contacted', '2024-04-15', '2024-05-11'),
    (151, 'Oskar', 'Koskinen', 'oskar.koskinen@techgroup.com', '1234567942', 'Tech Group', 'Technology', 'Trade Show', 'qualified', '2023-10-20', '2024-05-15'),
    (152, 'Ellen', 'Rantanen', 'ellen.rantanen@medicalsolutions.com', '1234567943', 'Medical Solutions', 'Healthcare', 'Referral', 'new', '2024-05-05', '2024-05-17'),
    (153, 'Leo', 'Heikkinen', 'leo.heikkinen@smartenergygroup.com', '1234567944', 'Smart Energy Group', 'Energy', 'Website', 'contacted', '2024-04-10', '2024-05-19'),
    (154, 'Saga', 'Peltola', 'saga.peltola@consultingcorp.com', '1234567945', 'Consulting Corp.', 'Consulting', 'referral', 'qualified', '2022-08-28', '2024-05-14'),
    (155, 'Max', 'Saarinen', 'max.saarinen@healthcareinnovations.com', '1234567946', 'Healthcare Innovations', 'Healthcare', 'Trade Show', 'contacted', '2024-04-03', '2024-05-12')
;

INSERT INTO sales_team VALUES
    (201, 'Hanna', 'Laine', 'hanna.laine@hamypt.com', '0412345678', 'Sales'),
    (202, 'Pekka', 'Korhonen', 'pekka.korhonen@hamypt.com', '0412345679', 'Sales'),
    (203, 'Sophie', 'Dubois', 'sophie.dubois@hamypt.com', '0412345680', 'Business Analytics'),
    (204, 'Antonio', 'Moreno', 'antonio.moreno@hamypt.com', '0412345681', 'Sales'),
    (205, 'Anna', 'Larsson', 'anna.larsson@hamypt.com', '0412345682', 'Portfolio'),
    (206, 'Michel', 'Lefebvre', 'michel.lefebvre@hamypt.com', '0412345683', 'Sales'),
    (207, 'Katri', 'Salmi', 'katri.salmi@hamypt.com', '0412345684', 'Portfolio'),
    (208, 'Matteo', 'Rossi', 'matteo.rossi@hamypt.com', '0412345685', 'Innovation'),
    (209, 'Eva', 'Garcia', 'eva.garcia@hamypt.com', '0412345686', 'Sales'),
    (210, 'Julien', 'Dupont', 'julien.dupont@hamypt.com', '0412345687', 'Business Development'),
    (211, 'Kaisa', 'Mäkinen', 'kaisa.makinen@hamypt.com', '0412345688', 'Sales'),
    (212, 'Manuel', 'Fernández', 'manuel.fernandez@hamypt.com', '0412345689', 'Strategic Marketing'),
    (213, 'Nina', 'Jensen', 'nina.jensen@hamypt.com', '0412345690', 'Sales'),
    (214, 'Luca', 'Ricci', 'luca.ricci@hamypt.com', '0412345691', 'Strategic Marketing'),
    (215, 'Olga', 'Ivanova', 'olga.ivanova@hamypt.com', '0412345692', 'Sales'),
    (216, 'Jan', 'Novák', 'jan.novak@hamypt.com', '0412345693', 'Business Development'),
    (217, 'Marie', 'Lefèvre', 'marie.lefevre@hamypt.com', '0412345694', 'Strategic Marketing'),
    (218, 'Andreas', 'Müller', 'andreas.mueller@hamypt.com', '0412345695', 'Sales'),
    (219, 'Sara', 'Gustafsson', 'sara.gustafsson@hamypt.com', '0412345696', 'Sales'),
    (220, 'Marco', 'Bianchi', 'marco.bianchi@hamypt.com', '0412345697', 'Business Analytics'),
    (221, 'Hanna', 'Andersson', 'hanna.andersson@hamypt.com', '0412345698', 'Strategic Marketing'),
    (222, 'Katarzyna', 'Nowak', 'katarzyna.nowak@hamypt.com', '0412345699', 'Business Development'),
    (223, 'Johan', 'Lindberg', 'johan.lindberg@hamypt.com', '0412345700', 'Business Analytics'),
    (224, 'Lucía', 'González', 'lucia.gonzalez@hamypt.com', '0412345701', 'Sales'),
    (225, 'Alessandro', 'Rizzo', 'alessandro.rizzo@hamypt.com', '0412345702', 'Portfolio'),
    (226, 'Natalia', 'Kowalska', 'natalia.kowalska@hamypt.com', '0412345703', 'Business Analytics'),
    (227, 'Samuel', 'Andersen', 'samuel.andersen@hamypt.com', '0412345704', 'Sales'),
    (228, 'Inês', 'Santos', 'ines.santos@hamypt.com', '0412345705', 'Innovation'),
    (229, 'Tomáš', 'Novotný', 'tomas.novotny@hamypt.com', '0412345706', 'Sales')
;

INSERT INTO interactions VALUES
    (50, 142, 201, '2024-05-05', 'Phone Call', 'Discussed product features and pricing.'),
    (51, 100, 202, '2024-05-12', 'Email', 'Sent follow-up email regarding proposal.'),
    (52, 101, 203, '2024-04-09', 'Meeting', 'Had a meeting to discuss project requirements.'),
    (53, 102, 204, '2024-03-10', 'Demo', 'Presented customized demo based on client needs.'),
    (54, 103, 205, '2024-02-12', 'Follow-up Call', 'Followed up on previous discussions.'),
    (55, 104, 206, '2024-01-14', 'Email', 'Sent email with additional information.'),
    (56, 144, 208, '2024-05-16', 'Meeting', 'Scheduled meeting for further discussions.'),
    (57, 106, 209, '2024-04-18', 'Phone Call', 'Discussed project timeline and milestones.'),
    (58, 145, 209, '2024-03-20', 'Follow-up Email', 'Sent follow-up email with pricing details.'),
    (59, 108, 210, '2024-04-22', 'Demo', 'Conducted a product demonstration.'),
    (60, 109, 211, '2024-02-24', 'Meeting', 'Held a meeting to review project progress.'),
    (61, 146, 212, '2024-03-26', 'Phone Call', 'Followed up on action items from previous meeting.'),
    (62, 111, 214, '2024-05-15', 'Email', 'Sent email with project proposal.'),
    (63, 112, 215, '2024-05-10', 'Meeting', 'Met with client to discuss contract terms.'),
    (64, 113, 217, '2024-05-01', 'Demo', 'Gave a live demo of our software platform.'),
    (65, 114, 218, '2024-04-03', 'Follow-up Call', 'Followed up on demo feedback.'),
    (66, 115, 218, '2024-05-05', 'Email', 'Sent email with product updates.'),
    (67, 148, 219, '2024-03-07', 'Meeting', 'Scheduled kickoff meeting for project.'),
    (68, 117, 220, '2024-03-09', 'Phone Call', 'Reviewed project requirements over the phone.'),
    (69, 118, 221, '2024-04-11', 'Follow-up Email', 'Sent follow-up email with meeting summary.'),
    (70, 149, 222, '2024-05-13', 'Demo', 'Provided a demo of our software solution.'),
    (71, 120, 222, '2024-04-15', 'Meeting', 'Met with stakeholders to discuss project scope.'),
    (72, 121, 223, '2024-02-17', 'Phone Call', 'Discussed project timeline and deliverables.'),
    (73, 122, 225, '2024-03-19', 'Email', 'Sent email with project roadmap.'),
    (74, 123, 225, '2024-01-21', 'Follow-up Call', 'Followed up on outstanding action items.'),
    (75, 124, 226, '2024-04-23', 'Meeting', 'Conducted progress review meeting with team.'),
    (76, 125, 227, '2024-05-10', 'Phone Call', 'Addressed client concerns over the phone.'),
    (77, 126, 228, '2024-02-27', 'Follow-up Email', 'Sent follow-up email with meeting minutes.'),
    (78, 150, 229, '2024-03-29', 'Demo', 'Performed live demo for new product features.'),
    (79, 151, 201, '2024-04-01', 'Meeting', 'Met with client to review project milestones.'),
    (80, 129, 202, '2024-02-03', 'Phone Call', 'Clarified project requirements over the phone.'),
    (81, 153, 203, '2024-05-05', 'Follow-up Call', 'Followed up on project status.'),
    (82, 131, 204, '2024-05-07', 'Email', 'Sent email with progress update.'),
    (83, 132, 204, '2024-03-09', 'Meeting', 'Conducted project status meeting with stakeholders.'),
    (84, 133, 205, '2024-04-11', 'Phone Call', 'Addressed client questions and concerns.'),
    (85, 154, 206, '2024-03-13', 'Follow-up Email', 'Sent follow-up email with action items.'),
    (86, 125, 207, '2024-04-15', 'Demo', 'Provided training demo for new system features.'),
    (87, 136, 208, '2024-03-17', 'Meeting', 'Met with project team to discuss next steps.'),
    (88, 137, 209, '2024-02-19', 'Phone Call', 'Discussed project timeline updates.'),
    (89, 138, 210, '2024-01-21', 'Follow-up Call', 'Followed up on client feedback.'),
    (90, 139, 210, '2024-03-23', 'Email', 'Sent email with project deliverables.'),
    (91, 140, 222, '2024-04-25', 'Meeting', 'Conducted project review meeting with client.'),
    (92, 141, 229, '2024-05-27', 'Phone Call', 'Addressed client inquiries over the phone.')
;

INSERT INTO lead_assignments VALUES 
	(1, 100, 202, '2024-05-20'),
    (2, 101, 203, '2024-03-20'),
    (3, 102, 204, '2024-04-03'),
    (4, 104, 206, '2024-01-25'),
    (5, 106, 209, '2024-02-20'),
    (6, 108, 210, '2024-03-01'),
    (7, 109, 211, '2024-04-04'),
    (8, 111, 203, '2024-05-01'),
    (9, 112, 215, '2024-04-10'),
    (10, 114, 218, '2024-03-25'),
    (11, 115, 218, '2024-05-05'),
    (12, 117, 220, '2024-03-09'),
    (13, 118, 221, '2024-03-10'),
    (14, 120, 222, '2024-05-20'),
    (15, 144, 225, '2024-04-15'),
    (16, 122, 225, '2024-01-20'),
    (17, 104, 206, '2023-02-20'),
    (18, 103, 224, '2024-05-15'),
    (19, 136, 208, '2024-04-20'),
    (20, 132, 204, '2023-10-20'),
    (21, 132, 204, '2024-02-15'),
    (22, 115, 218, '2024-04-10'),
    (23, 151, 201, '2024-01-10'),
    (24, 145, 209, '2024-05-01'),
    (25, 129, 202, '2024-02-01'),
    (26, 125, 207, '2024-04-20')
;

INSERT INTO opportunities VALUES
	(1, 103, 'PXT400T', 400000, 'qualification', 205),
    (2, 104, 'PMR2500', 500000, 'negotiation', 203),
    (3, 109, 'PXT400H', 500000, 'negotiation', 211),
    (4, 111, 'PMR70i', 450000, 'qualification', 209),
    (5, 113, 'PMR70i', 400000, 'prospecting', 217),
    (6, 115, 'PMR2500', 350000, 'closed', 218),
    (7, 120, 'PXT400H', 200000, 'prospecting', 221),
    (8, 124, 'PXT400T', 650000, 'qualification', 226),
    (9, 125, 'PMR2500', 480000, 'closed', 201),
    (10, 129, 'PMR70i', 200000, 'qualification', 202),
    (11, 132, 'PXT80i', 650000, 'proposal', 204),
    (12, 135, 'PMR2500', 300000, 'prospecting', 222),
    (13, 136, 'PMR70i', 370000, 'closed', 208),
    (14, 138, 'PMR2500', 400000, 'qualification', 210),
    (15, 141, 'PMR2500', 300000, 'qualification', 229),
    (16, 145, 'PXT400H', 200000, 'prospecting', 209),
    (17, 151, 'PXT80i', 550000, 'qualification', 201),
    (18, 154, 'PMR70i', 300000, 'prospecting', 220),
    (19, 120, 'PMR2500', 600000, 'prospecting', 223),
    (20, 123, 'PXT400T', 400000, 'prospecting', 225)
;

-- ------------------------------------------------------------------------------------------

-- -- ALTER TABLE

-- ADD COLUMNS 'country' AND 'region' TO TABLE 'leads'

ALTER TABLE leads
ADD COLUMN country VARCHAR(100),
ADD COLUMN region ENUM('APAC', 'LAD', 'MEA', 'NA', 'NDEE', 'WSE');


-- INSERT ADDITIONAL DATA BY UPDATING TABLE

UPDATE leads
SET country = CASE
	WHEN lead_id IN (99, 101, 103, 104, 106, 107, 108, 111, 115, 117, 121, 125, 127, 132, 135, 139, 154) THEN 'Finland'
    WHEN lead_id IN (100, 113, 118, 123, 129, 131, 134, 144) THEN 'Sweden'
    WHEN lead_id IN (105, 128, 148) THEN 'Denmark'
    WHEN lead_id IN (112, 130, 141, 146, 150) THEN 'Germany'
    WHEN lead_id IN (110, 137, 152) THEN 'France'
    WHEN lead_id IN (109, 138, 143) THEN 'Estonia'
    WHEN lead_id IN (124, 140, 153) THEN 'UK'
    WHEN lead_id IN (102, 149) THEN 'The Netherlands'
    WHEN lead_id IN (119, 142) THEN 'Norway'
    WHEN lead_id = 120 THEN 'Spain'
    WHEN lead_id = 122 THEN 'Singapore'
    WHEN lead_id = 114 THEN 'KSA'
    WHEN lead_id = 116 THEN 'USA'
    WHEN lead_id = 126 THEN 'Greece'
    WHEN lead_id = 133 THEN 'Portugal'
    WHEN lead_id = 136 THEN 'China'
    WHEN lead_id = 145 THEN 'India'
    WHEN lead_id = 147 THEN 'Mexico'
    WHEN lead_id = 151 THEN 'South Africa'
    WHEN lead_id = 155 THEN 'Australia'
    ELSE 'unknown'
END;
    

UPDATE leads
SET region = CASE
	WHEN country IN ('Finland', 'Sweden', 'Denmark', 'Estonia', 'Norway') THEN 'NDEE'
    WHEN country IN ('Germany', 'The Netherlands', 'France', 'Spain', 'Greece', 'Belgium', 'UK', 'Portugal', 'Switzerland', 'Italy') THEN 'WSE'
    WHEN country IN ('USA', 'Canada', 'Mexico') THEN 'NA'
    WHEN country IN ('China', 'Malaysia', 'India', 'Singapore', 'Australia', 'New Zealand', 'Japan', 'South Korea') THEN 'APAC'
    WHEN country IN ('KSA', 'UAE', 'South Africa', 'Egypt', 'Qatar') THEN 'MEA'
    WHEN country IN ('Brazil', 'Venezuela', 'Bolivia') THEN 'LAD'
    ELSE 'unknown'
END;


UPDATE leads
SET lead_source = 'cold call' WHERE lead_source = 'Cold Call';

UPDATE leads
SET lead_source = 'webinar' WHERE lead_source = 'Webinar';
