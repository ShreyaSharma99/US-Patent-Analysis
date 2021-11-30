SELECT COUNT(*) AS num_assignments, convey_ty AS type FROM
assignment_conveyance 
GROUP BY convey_ty
ORDER BY convey_ty;
--1--
--Frequency of each type of transactions in the dataset
