select
    concat(feedback_id, '-', order_id) as feedback_id,
    order_id,
    feedback_form_sent_date as feedback_form_sent_at,
    feedback_answer_date as feedback_answer_at,
    feedback_score
from {{ source('sales_database', 'feedback') }}

