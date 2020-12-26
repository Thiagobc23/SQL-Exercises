-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
select p.Name 
from undergoes u, physician p 
where u.Physician = p.EmployeeID 
and u.Physician not in (select t.Physician from trained_in t where u.Procedures = t.Treatment);

-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
select p.Name Doctor, pro.Name 'Procedure', u.DateUndergoes 'Procedure Date', pa.Name 'Patient name'
from undergoes u, physician p, procedures pro, patient pa
where u.Physician = p.EmployeeID 
and u.Procedures = pro.Code
and u.Patient = pa.SSN
and u.Physician not in (select t.Physician from trained_in t where u.Procedures = t.Treatment);

-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
select p.name 
from undergoes u 
left join physician p on (u.Physician = p.EmployeeID)
left join trained_in t on (u.Procedures = t.Treatment and u.Physician = t.Physician)
where t.Physician is not null
and CertificationExpires < DateUndergoes;

-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
select 
	p.name Doctor, 
    pro.name 'Procedure', 
    u.DateUndergoes 'Procedure Date', 
    pa.Name Patient, 
    t.CertificationExpires 'Cert. exp. date'
from undergoes u 
left join physician p on (u.Physician = p.EmployeeID)
left join trained_in t on (u.Procedures = t.Treatment and u.Physician = t.Physician)
left join procedures pro on (u.Procedures = pro.Code)
left join patient pa on (u.Patient = pa.SSN)
where t.Physician is not null
and t.CertificationExpires < u.DateUndergoes;

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. 
-- Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, 
-- examination room, and the name of the patient's primary care physician.
select 
	p.Name Patient, 
    ph1.Name 'Physician',
    n.Name Nurse,
    a.Start, 
    a.End,
    a.ExaminationRoom Room,
    ph2.name 'Primary Care Physician'
from appointment a 
left join patient p on (a.Patient = p.SSN) 
left join physician ph1 on (a.Physician = ph1.EmployeeID)
left join nurse n on (a.PrepNurse = n.EmployeeID)
left join physician ph2 on (p.PCP = ph2.EmployeeID)
where p.PCP <> a.Physician;

-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. 
-- There are no constraints in force to prevent inconsistencies between these two tables. 
-- More specifically, the Undergoes table may include a row where the patient ID 
-- does not match the one we would obtain from the Stay table through the Undergoes.
-- Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
select * from stay s, undergoes u where s.StayID = u.Stay and s.Patient <> u.Patient;

-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
select n.Name 
from on_call o 
left join nurse n on n.EmployeeID = o.Nurse 
where o.BlockCode = (select room.BlockCode 
					 from room 
                     where room.RoomNumber = 123);

-- 8.8 The hospital has several examination rooms where appointments take place.
-- Obtain the number of appointments that have taken place in each examination room.
select count(1), ExaminationRoom from appointment group by ExaminationRoom;

-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician),
-- such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.

select pa.name
from prescribes pr, patient pa 
where pa.SSN = pr.Patient 
and pr.Physician = pa.PCP
and pa.SSN in (select u.Patient from undergoes u where u.Procedures in (select Code from procedures pro where pro.Cost > 5000))
and pa.SSN in (select Patient from (
					select count(1) qty, a.Patient 
					from appointment a, nurse n 
					where a.PrepNurse = n.EmployeeID 
					and Registered = true 
					group by a.Patient) x
					where qty >= 2)
and pa.PCP in (select ph.EmployeeID from physician ph left join department d on ph.EmployeeID = d.Head where d.Head is null)