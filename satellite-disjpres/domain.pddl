(define (domain satellite_ext)
    (:requirements :derived-predicates :disjunctive-preconditions :existential-preconditions :negative-preconditions :strips :typing)
    (:types
        direction instrument mode satellite - object
    )
    (:predicates (calibrate_pp ?s - satellite ?i - instrument ?d - direction)  (calibrated ?i - instrument)  (calibration_target ?i - instrument ?d - direction)  (have_image ?d - direction ?m - mode)  (have_image__ug ?d - direction ?m - mode)  (have_image_g ?d - direction ?m - mode)  (on_board ?i - instrument ?s - satellite)  (pointing ?s - satellite ?d - direction)  (pointing__ug ?s - satellite ?d - direction)  (pointing_g ?s - satellite ?d - direction)  (power_avail ?s - satellite)  (power_on ?i - instrument)  (supports ?i - instrument ?m - mode)  (switch_off_pp ?i - instrument ?s - satellite)  (switch_on_pp ?i - instrument ?s - satellite)  (take_image_pp ?s - satellite ?d - direction ?i - instrument ?m - mode)  (turn_to_pp ?s - satellite ?d_new - direction ?d_prev - direction))
    (:action calibrate
        :parameters (?s - satellite ?i - instrument ?d - direction)
        :precondition (and (on_board ?i ?s) (calibration_target ?i ?d) (pointing ?s ?d) (power_on ?i) (or (exists (?mode0 - mode) (and (calibration_target ?i ?d) (on_board ?i ?s) (pointing ?s ?d) (power_on ?i) (supports ?i ?mode0) (not (have_image ?d ?mode0)) (have_image_g ?d ?mode0))) (exists (?mode0 - mode ?direction1 - direction) (and (calibration_target ?i ?d) (on_board ?i ?s) (pointing ?s ?d) (power_on ?i) (supports ?i ?mode0) (not (have_image ?direction1 ?mode0)) (have_image_g ?direction1 ?mode0)))))
        :effect (calibrated ?i)
    )
     (:action switch_off
        :parameters (?i - instrument ?s - satellite)
        :precondition (and (on_board ?i ?s) (power_on ?i) (exists (?direction0 - direction ?instrument1 - instrument ?mode0 - mode) (and (calibration_target ?instrument1 ?direction0) (on_board ?i ?s) (on_board ?instrument1 ?s) (pointing ?s ?direction0) (power_on ?i) (supports ?instrument1 ?mode0) (not (have_image ?direction0 ?mode0)) (have_image_g ?direction0 ?mode0))))
        :effect (and (not (power_on ?i)) (power_avail ?s))
    )
     (:action switch_on
        :parameters (?i - instrument ?s - satellite)
        :precondition (and (on_board ?i ?s) (power_avail ?s) (or (exists (?direction0 - direction ?mode0 - mode) (and (calibration_target ?i ?direction0) (on_board ?i ?s) (pointing ?s ?direction0) (power_avail ?s) (supports ?i ?mode0) (not (have_image ?direction0 ?mode0)) (have_image_g ?direction0 ?mode0))) (exists (?direction0 - direction ?mode0 - mode ?direction1 - direction) (and (calibration_target ?i ?direction0) (on_board ?i ?s) (pointing ?s ?direction1) (power_avail ?s) (supports ?i ?mode0) (not (have_image ?direction0 ?mode0)) (have_image_g ?direction0 ?mode0))) (exists (?direction0 - direction ?mode0 - mode ?direction1 - direction) (and (calibration_target ?i ?direction0) (on_board ?i ?s) (pointing ?s ?direction0) (power_avail ?s) (supports ?i ?mode0) (not (have_image ?direction1 ?mode0)) (have_image_g ?direction1 ?mode0))) (exists (?direction0 - direction ?mode0 - mode ?direction1 - direction) (and (calibration_target ?i ?direction0) (on_board ?i ?s) (pointing ?s ?direction1) (power_avail ?s) (supports ?i ?mode0) (not (have_image ?direction1 ?mode0)) (have_image_g ?direction1 ?mode0))) (exists (?direction0 - direction ?mode0 - mode ?direction1 - direction ?direction2 - direction) (and (calibration_target ?i ?direction0) (on_board ?i ?s) (pointing ?s ?direction1) (power_avail ?s) (supports ?i ?mode0) (not (have_image ?direction2 ?mode0)) (have_image_g ?direction2 ?mode0)))))
        :effect (and (power_on ?i) (not (calibrated ?i)) (not (power_avail ?s)))
    )
     (:action take_image
        :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
        :precondition (and (calibrated ?i) (on_board ?i ?s) (supports ?i ?m) (power_on ?i) (pointing ?s ?d) (not (have_image ?d ?m)) (have_image_g ?d ?m))
        :effect (have_image ?d ?m)
    )
     (:action turn_to
        :parameters (?s - satellite ?d_new - direction ?d_prev - direction)
        :precondition (and (pointing ?s ?d_prev) (not (pointing ?s ?d_new)) (or (exists (?instrument0 - instrument ?mode0 - mode) (and (calibrated ?instrument0) (on_board ?instrument0 ?s) (pointing ?s ?d_prev) (power_on ?instrument0) (supports ?instrument0 ?mode0) (not (have_image ?d_new ?mode0)) (have_image_g ?d_new ?mode0))) (exists (?instrument0 - instrument ?mode0 - mode ?direction2 - direction) (and (calibration_target ?instrument0 ?d_new) (on_board ?instrument0 ?s) (pointing ?s ?d_prev) (power_on ?instrument0) (supports ?instrument0 ?mode0) (not (have_image ?direction2 ?mode0)) (have_image_g ?direction2 ?mode0))) (exists (?instrument0 - instrument ?mode0 - mode) (and (calibration_target ?instrument0 ?d_new) (on_board ?instrument0 ?s) (pointing ?s ?d_prev) (power_on ?instrument0) (supports ?instrument0 ?mode0) (not (have_image ?d_prev ?mode0)) (have_image_g ?d_prev ?mode0))) (and (pointing ?s ?d_prev) (not (pointing ?s ?d_new)) (pointing_g ?s ?d_new)) (exists (?instrument0 - instrument ?mode0 - mode) (and (calibration_target ?instrument0 ?d_new) (on_board ?instrument0 ?s) (pointing ?s ?d_prev) (power_on ?instrument0) (supports ?instrument0 ?mode0) (not (have_image ?d_new ?mode0)) (have_image_g ?d_new ?mode0)))))
        :effect (and (pointing ?s ?d_new) (not (pointing ?s ?d_prev)))
    )
)
