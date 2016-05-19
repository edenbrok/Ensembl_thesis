INSERT INTO assembly VALUES(00000, 00000, 00000, 00000, 00000, 00000, 0000);
DELETE FROM assembly WHERE asm_seq_region_id = 00000;

INSERT INTO attrib_type VALUES(00000, 'boo', 'baa', 'bee');
DELETE FROM attrib_type WHERE code = 'boo';

INSERT INTO coord_system VALUES(00000, 153, 'beyonce', 4, 14, 'default_version');
DELETE FROM coord_system WHERE name = 'beyonce';

INSERT INTO dna VALUES(999999, 'ttip sucks but');
DELETE FROM dna WHERE seq_region_id = 999999;

INSERT INTO seq_region VALUES(999999, 'beyonce', 123456, 3);
DELETE FROM seq_region WHERE seq_region_id = 999999;

INSERT INTO seq_region_attrib VALUES(999999, 6, 'beyonce');
DELETE FROM seq_region_attrib WHERE seq_region_id = 999999;

SELECT * FROM seq_region_attrib_audit WHERE updated_on != '2016-05-17 16:19:40';

#takes forever/cancesl out
DELETE FROM assembly WHERE
 ROW(asm_seq_region_id, cmp_seq_region_id, asm_start, asm_end, cmp_start, cmp_end, ori) IN
 (SELECT asm_seq_region_id, cmp_seq_region_id, asm_start, asm_end, cmp_start, cmp_end, ori FROM assembly_audit);
 
 
SELECT * FROM assembly_exception WHERE
	assemlby_exception_id IN
    (SELECT assembly_exception_id FROM assembly_exception_audit);