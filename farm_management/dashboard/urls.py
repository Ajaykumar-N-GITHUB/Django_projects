from django.urls import path
from dashboard.views import Dashboard, AddRecordView, GetRecordView, ProfitLossView, RemoveRecordView, UpdateRecordView, WorkerLongInputView, LogDownloadView
from dashboard.views import SetReminderView, PieBarView, FutureExpensesView,ReportDownloadView, WorkerDashboardView, AddWorkerView, RemoveWorkerView
urlpatterns = [
    path('display',Dashboard.as_view()),
    path('worker_input', WorkerDashboardView.as_view(), name = 'worker_input'),
    path('worker_long_input', WorkerLongInputView.as_view(), name = 'worker_long_input'),
    path('add_record', AddRecordView.as_view(), name='add_record'),
    path('add_worker', AddWorkerView.as_view(), name='add_worker'),
    path('remove_worker', RemoveWorkerView.as_view(), name='fetch_worker'),
    path('fetch_records', GetRecordView.as_view(), name ='fetch_records'),
    path('update_record', UpdateRecordView.as_view(), name='update_record'),
    path('remove_record', RemoveRecordView.as_view(), name='remove_record'),
    path('profit_loss', ProfitLossView.as_view(), name='profit_loss'),
    path('set_reminder', SetReminderView.as_view(), name = 'set_reminder'),
    path('pie_bar', PieBarView.as_view(), name = 'pie_bar'),
    path('future_expenses', FutureExpensesView.as_view(), name='future_expenses'),
    path('report_download', ReportDownloadView.as_view(), name='report_download'),
    path('get-report', LogDownloadView.as_view(), name='get_report'),
]