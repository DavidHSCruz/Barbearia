import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/scheduling_bloc.dart';

class SchedulePage extends StatelessWidget {
  final bool isGuest;

  const SchedulePage({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => sl<SchedulingBloc>()..add(SchedulingLoadData()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(l10n.scheduleServiceTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _ScheduleForm(isGuest: isGuest),
      ),
    );
  }
}

class _ScheduleForm extends StatefulWidget {
  final bool isGuest;

  const _ScheduleForm({required this.isGuest});

  @override
  State<_ScheduleForm> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<_ScheduleForm> {
  int? _selectedServiceId;
  int? _selectedBarberId;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<SchedulingBloc, SchedulingState>(
      builder: (context, state) {
        if (state is SchedulingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SchedulingFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message, style: TextStyle(color: colorScheme.error)),
                ElevatedButton(
                  onPressed: () =>
                      context.read<SchedulingBloc>().add(SchedulingLoadData()),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          );
        } else if (state is SchedulingLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.isGuest)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.tertiary),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.onTertiaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.guestBookingMessage,
                            style: TextStyle(
                              color: colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Seleção de Serviço
                Text(
                  l10n.serviceLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  initialValue: _selectedServiceId,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  items: state.services.map((service) {
                    final priceFormatted = NumberFormat.simpleCurrency(
                      locale: Localizations.localeOf(context).toString(),
                    ).format(service.price);
                    return DropdownMenuItem<int>(
                      value: service.id,
                      child: Text('${service.name} - $priceFormatted'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedServiceId = value);
                  },
                ),
                const SizedBox(height: 24),

                // Seleção de Barbeiro
                Text(
                  l10n.barberLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  initialValue: _selectedBarberId,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  items: state.barbers.map((barber) {
                    return DropdownMenuItem<int>(
                      value: barber.id,
                      child: Text(barber.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedBarberId = value);
                  },
                ),
                const SizedBox(height: 24),

                // Seleção de Data
                Text(
                  l10n.dateLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMd(
                            Localizations.localeOf(context).toString(),
                          ).format(_selectedDate),
                        ),
                        Icon(Icons.calendar_today, color: colorScheme.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Seleção de Horário
                Text(
                  l10n.timeLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (picked != null) {
                      setState(() => _selectedTime = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedTime.format(context)),
                        Icon(Icons.access_time, color: colorScheme.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Botão de Confirmar
                ElevatedButton(
                  onPressed: () {
                    // Implementar lógica de confirmação
                    if (_selectedServiceId != null &&
                        _selectedBarberId != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.scheduleSuccess),
                          backgroundColor: Colors
                              .green, // Pode ser mantido ou usar cores de sucesso customizadas
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.selectServiceAndBarber),
                          backgroundColor: colorScheme.error,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    l10n.confirmSchedule,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
