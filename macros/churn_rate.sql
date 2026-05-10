{% macro churn_rate(churn_column, id_column) %}
    round(
        count(case when {{ churn_column }}
            then {{ id_column }} end) * 100.0
        / nullif(count({{ id_column }}), 0)
    , 1)
{% endmacro %}
