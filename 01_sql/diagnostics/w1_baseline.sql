WITH key_frequency AS (
    SELECT
        unique_key,
        COUNT(*) AS occurrences
    FROM raw_311
    WHERE unique_key IS NOT NULL
    GROUP BY unique_key
),

duplicate_summary AS (
    SELECT
        COALESCE(
            SUM(
                CASE
                    WHEN occurrences > 1 THEN 1
                    ELSE 0
                END
            ),
            0
        ) AS duplicate_key_value_count,

        COALESCE(
            SUM(
                CASE
                    WHEN occurrences > 1 THEN occurrences - 1
                    ELSE 0
                END
            ),
            0
        ) AS duplicate_excess_row_count
    FROM key_frequency
)

SELECT
    COUNT(*) AS total_row_count,
    MIN(created_date) AS earliest_created_date,
    MAX(created_date) AS latest_created_date,

    COALESCE(
        SUM(
            CASE
                WHEN NULLIF(TRIM(borough), '') IS NULL THEN 1
                ELSE 0
            END
        ),
        0
    ) AS blank_borough_count,

    COALESCE(
        SUM(
            CASE
                WHEN NULLIF(TRIM(complaint_type), '') IS NULL THEN 1
                ELSE 0
            END
        ),
        0
    ) AS blank_complaint_type_count,

    COALESCE(
        SUM(
            CASE
                WHEN created_date IS NULL THEN 1
                ELSE 0
            END
        ),
        0
    ) AS missing_created_date_count,

    COALESCE(
        SUM(
            CASE
                WHEN closed_date IS NULL THEN 1
                ELSE 0
            END
        ),
        0
    ) AS missing_closed_date_count,

    COALESCE(
        SUM(
            CASE
                WHEN unique_key IS NULL THEN 1
                ELSE 0
            END
        ),
        0
    ) AS missing_unique_key_count,

    COALESCE(
        SUM(
            CASE
                WHEN created_date IS NOT NULL
                 AND closed_date IS NOT NULL
                 AND closed_date < created_date
                THEN 1
                ELSE 0
            END
        ),
        0
    ) AS invalid_date_count,

    (
        SELECT duplicate_key_value_count
        FROM duplicate_summary
    ) AS duplicate_key_value_count,

    (
        SELECT duplicate_excess_row_count
        FROM duplicate_summary
    ) AS duplicate_excess_row_count

FROM raw_311;