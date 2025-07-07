from django.urls import path
from dashboard.views import Dashboard, AddRecordView, GetRecordView, ProfitLossView, RemoveRecordView
from dashboard.views import SetReminderView, PieBarView, FutureExpensesView,ReportDownloadView
urlpatterns = [
    path('display',Dashboard.as_view()),
    path('add_record', AddRecordView.as_view(), name='add_record'),
    path('fetch_records', GetRecordView.as_view(), name ='fetch_records'),
    path('profit_loss', ProfitLossView.as_view(), name='profit_loss'),
    path('remove_record', RemoveRecordView.as_view(), name='remove_record'),
    path('set_reminder', SetReminderView.as_view(), name = 'set_reminder'),
    path('pie_bar', PieBarView.as_view(), name = 'pie_bar'),
    path('future_expenses', FutureExpensesView.as_view(), name='future_expenses'),
    path('report_download', ReportDownloadView.as_view(), name='report_download')
]